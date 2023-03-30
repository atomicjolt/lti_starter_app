# Class representing an lti 1.1 launch.
#
# When a controller includes the `lti_support` concern, an
# instance of this class will be accessible from the 'lti' property.

module Lti
  class Request

    attr_reader :lti_params

    # delegate all other methods to the lti_params class
    delegate_missing_to :@lti_params

    def initialize(request, application_instance, skip_validation: false)
      @application_instance = application_instance
      @request = request
      @lti_params = Lti::Params.new(request.params)

      validate! unless skip_validation # validation is skipped only during omniauth callback
    end

    def validate!
      if !valid_lti_request?(@application_instance.lti_secret)
        raise Exceptions::SignatureValidationError
      end
    end

    def lti_token
      nil
    end

    def self.oauth_consumer_key(request)
      key = request.env["oauth_consumer_key"] ||
        request.params["oauth_consumer_key"] ||
        request.session[:oauth_consumer_key]

      if key.blank?
        if bearer_token = request.get_header("HTTP_AUTHORIZATION")
          token = bearer_token.split(" ").last
          decoded_token = AuthToken.decode(token, nil, false)
          # Canvas sticks the `kid` in the header
          # We stick the `kid` in the payload
          key = decoded_token[PAYLOAD]["kid"] || decoded_token[HEADER]["kid"]
        end
      end
      key
    end

    def user_from_lti
      # Canvas notes:
      #
      #  Canvas allows merging of two users which complicates things here.
      #  If user A is in course C, and then gets merged into user B, this is what happens:
      #
      #    Canvas will delete user A from the database, and A's lms_user_id is no longer valid. The user will
      #    get B's lms_user_id.
      #
      #    On LTI launches in course C, Canvas will continue to send A's OLD lti_user_id in the course,
      #    so we will not see a change there. However, it will send the B's NEW lms_user_id.
      #
      #    If the user is then added to another course C1, we will see B's NEW lti_user_id on LTI
      #    launches in course C1. We will continue to see A's OLD lti_user_id on launches into C.
      #
      #    In the unusual case that B was also in C before the merge, the merged user will continue to
      #    send A's OLD lti_user_id on launches in C.
      #
      # We use lti_user_id as the key when looking up a user, so in the above scenario the
      # user will have a different user records for course C and C1 on our end.  This is consistent with
      # the LTI specifications, but might complicate reports which span courses.

      # Make sure there is a user_id in the params. If there is not - which happens when the user is not logged
      # in to the LMS then user_id is nil. When it is nil we create a single user with lti_user_id == nil
      # and we find that one user on all subsequent requests within the same session.
      if @request.params[:user_id].present?
        lti_user_id = @request.params[:user_id]

        # Match on lti_user_id if possible. The lms_user_id may change, but the lti_user_id
        # should be stable.
        user = User.find_by(lti_user_id: lti_user_id)

        # Match on legacy_lti_user_id if possible. This happens when the account has
        # already migrated to lti advantage
        if user.blank?
          user = User.where(legacy_lti_user_id: lti_user_id).order("id ASC").first
        end

        if user
          # Update the lms_user_id in case it changed. This happens during user merge in Canvas.
          user.update!(lms_user_id: lms_user_id) if lms_user_id.present?
        end


        # Match on only lms_user_id if the lti_user_id is nil. This happens when a user uses OAuth to create and
        # account before they ever do an LTI launch.
        if user.blank? && lms_user_id.present?
          if user = User.find_by(lms_user_id: lms_user_id, lti_user_id: nil)
            # This is the first LTI launch after an OAuth so update the lti_user_id.
            user.update!(lti_user_id: lti_user_id)
          end
        end
      end

      # Check to see if we are working with a user who is not logged into Canvas
      if user.blank? && @request.session[:non_authenticated_user_id]
        user = User.find(@request.session[:non_authenticated_user_id])
      end

      if user.blank?
        if non_authenticated_user?
          user = _generate_non_authenticated_user
          @request.session[:non_authenticated_user_id] = user.id
        else
          user = _generate_new_lti_user(@request.params)
        end
      else
        # Update user's name
        name = _generate_name(@request.params)
        user.name = name if user.name != name
        if user.lms_user_id.blank? && lms_user_id.present?
          user.lms_user_id = lms_user_id
        end
        user.legacy_lti_user_id = lti_user_id
        if !user.save
          error = user.errors.pluck(:messages).join(" ").to_s
          Rollbar.error("Unable to update user information during LTI launch. UserId: #{user.id}. Error: #{error}")
        end
        _update_roles(user, @request.params)
      end

      user
    end

    def lti_provider
      @lti_provider ||=
        @request.params[:tool_consumer_instance_guid] ||
        UrlHelper.safe_host(
          @request.referer ||
          @request.params["launch_presentation_return_url"] ||
          @request.params["custom_canvas_api_domain"],
        )
    end

    def account_launch?
      canvas_account_id && !canvas_course_id
    end

    def lms_course_id
      lms_course_id = canvas_course_id
      if lms_course_id.blank?
        # Here we manufacture an lms_course_id to use as an identifier for
        # scoping course resources.
        lms_course_id = "##{tool_consumer_instance_guid}##{context_id}"
      end
      lms_course_id
    end

    def canvas_api_domain
      @request.params[:custom_canvas_api_domain]
    end

    private

    def valid_lti_request?(lti_secret)
      # Remove path params. They aren't included in the lti form post and will mess up the signature
      path_params = @request.path_parameters

      lti_post_params = @request.params.except(*path_params.keys)
      Lti::Utils.clean_non_lti_params(lti_post_params)

      url = @request.url

      authenticator = IMS::LTI::Services::MessageAuthenticator.new(url, lti_post_params, lti_secret)
      authenticator.valid_signature? &&
        Nonce.valid?(@request.request_parameters["oauth_nonce"]) &&
        valid_timestamp?(lti_post_params["oauth_timestamp"])
    end

    def valid_timestamp?(oauth_timestamp)
      # If timestamp is older than 5 minutes it's invalid
      DateTime.strptime(oauth_timestamp, "%s") > 5.minutes.ago
    end

    def generate_email
      "generated-#{::SecureRandom::hex(10)}@#{domain_for_email}"
    end

    def _generate_name(params)
      params[:lis_person_name_full].presence ||
        "#{params[:lis_person_name_given]} #{params[:lis_person_name_family]}".strip
    end

    def _generate_new_lti_user(params)
      lti_user_id = params[:user_id]

      if @application_instance.anonymous?
        name = "anonymous"
      else
        # Generate a name from the LTI params
        name = _generate_name(params)
        name = params[:roles] if name.blank? # If the name is blank then use their role

      end
      email = generate_email

      user = User.new(email: email, name: name)
      user.skip_confirmation!
      user.password = ::SecureRandom::hex(15)
      user.password_confirmation = user.password
      user.lti_user_id = lti_user_id
      user.legacy_lti_user_id = lti_user_id
      user.lti_provider = lti_provider
      user.lms_user_id = lms_user_id
      user.create_method = User.create_methods[:lti]
      user.save!

      # store lti roles for the user
      _add_roles(user, params)

      user
    end

    def non_authenticated_user?
      @request.params[:user_id].blank?
    end

    def _generate_non_authenticated_user
      id = ::SecureRandom::hex(15)
      email = "generated-#{id}@#{domain_for_email}"
      user = User.new(email: email, name: "anonymous-#{id}")
      user.skip_confirmation!
      user.password = ::SecureRandom::hex(15)
      user.password_confirmation = user.password
      user.create_method = User.create_methods[:lti]
      user.save!
      user
    end

    def _add_roles(user, params)
      all_roles = lti_roles.split(",")
      # Only store roles that start with urn:lti:role to prevent using local roles
      roles = all_roles.select { |role| role.start_with?("urn:lti:") }

      # Check to see if we’re dealing with Canvas and the LTI launch claims
      # the user is "urn:lti:instrole:ims/lis/Administrator"
      if params["ext_roles"].present? &&
          params["roles"].present? &&
          roles.include?("urn:lti:instrole:ims/lis/Administrator")
        # Make sure that roles also includes “urn:lti:instrole:ims/lis/Administrator”
        # so we know for certain that the user has that role in the current context
        context_roles = params["roles"].split(",")
        if !context_roles.include?("urn:lti:instrole:ims/lis/Administrator")
          roles.delete("urn:lti:instrole:ims/lis/Administrator")
        end
      end

      roles.each do |role|
        user.add_to_role(role, params["context_id"])
      end
      roles
    end

    def _update_roles(user, params)
      roles = _add_roles(user, params)

      permissions = user.
        permissions.
        where(context_id: params[:context_id])

      roles_names = permissions.includes(:role).map { |per| per.role.name }
      diff = roles_names - roles
      # If the user has context roles that no longer are sent from canvas,
      # then delete them.
      if diff.present?
        to_delete = permissions.joins(:role).where(roles: { name: diff })
        to_delete.destroy_all
      end
    end

    def domain_for_email
      @request.params["custom_canvas_api_domain"] || Rails.application.secrets.application_main_domain
    end

    def lti_roles
      @request.params["ext_roles"] || @request.params["roles"]
    end

    def lms_user_id
      @request.params[:custom_canvas_user_id]
    end
  end
end
