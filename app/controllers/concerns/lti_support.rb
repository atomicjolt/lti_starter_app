require "jwt"

module Concerns
  module LtiSupport
    extend ActiveSupport::Concern

    included do
      helper_method :lti_provider
    end

    protected

    CANVAS_PUBLIC_LTI_KEYS_URL = "https://canvas.instructure.com/api/lti/security/jwks"
    CANVAS_BETA_PUBLIC_LTI_KEYS_URL = "https://canvas.beta.instructure.com/api/lti/security/jwks"

    def jwks_url
      url = canvas_url
      if url.include?("beta.instructure.com")
        CANVAS_BETA_PUBLIC_LTI_KEYS_URL
      elsif url.include?("instructure.com")
        CANVAS_PUBLIC_LTI_KEYS_URL
      end
    end

    def jwk_loader
      # TODO cache this
      JSON.parse(HTTParty.get(jwks_url).body).deep_symbolize_keys
    end

    def do_lti
      if token = params["id_token"]
        begin
          @lti_token, keys = JWT.decode(token, nil, true, { algorithms: ["RS256"], jwks: jwk_loader})
          return
        rescue JWT::JWKError
          # Handle problems with the provided JWKs
        rescue JWT::DecodeError
          # Handle other decode related issues e.g. no kid in header, no matching public key found etc.
        end
      elsif valid_lti_request?(current_application_instance.lti_secret)
        if user = user_from_lti
          # until the code to fix the valid lti request is up
          # then we will confirm emails here to use it on the course nav
          user.confirm unless user.confirmed?
          sign_in(user, event: :authentication)
          return
        end
      end
      user_not_authorized
    end

    def valid_lti_request?(lti_secret)
      authenticator = IMS::LTI::Services::MessageAuthenticator.new(request.url, request.request_parameters, lti_secret)
      authenticator.valid_signature? &&
        Nonce.valid?(request.request_parameters["oauth_nonce"]) &&
        valid_timestamp?
    end

    def lti_provider
      @lti_provider ||=
        params[:tool_consumer_instance_guid] ||
        UrlHelper.safe_host(
          request.referer ||
          params["launch_presentation_return_url"] ||
          params["custom_canvas_api_domain"],
        )
    end

    def user_from_lti
      lti_user_id = params[:user_id]

      # Match on both fields if possible
      user = User.find_by(lms_user_id: lms_user_id, lti_user_id: lti_user_id)

      # Match on only lms_user_id. This happens when a user uses OAuth to create and
      # account before they ever do an LTI launch.
      if user.blank?
        if user = User.find_by(lms_user_id: lms_user_id)
          if user.lti_user_id != lti_user_id
            user.update!(lti_user_id: lti_user_id)
          end
        end
      end

      # Find the user with just the lti_user_id
      user ||= User.find_by(lti_user_id: lti_user_id)

      if user.blank?
        user = _generate_new_lti_user(params)
        _attempt_uniq_email(user)
      else
        _update_roles(user, params)
      end

      user
    end

    private

    def valid_timestamp?
      # If timestamp is older than 5 minutes it's invalid
      if DateTime.strptime(request.request_parameters["oauth_timestamp"], "%s") < 5.minutes.ago
        false
      else
        true
      end
    end

    def generate_email
      "generated-#{params[:user_id]}@#{domain_for_email}"
    end

    def safe_save_email(user)
      user.save!
    rescue ActiveRecord::RecordInvalid => ex
      if ex.to_s == "Validation failed: Email has already been taken"
        false
      else
        raise ex
      end
    end

    def _attempt_uniq_email(user)
      count = 0 # don't go infinite
      while !safe_save_email(user) && count < 10
        user.email = generate_email
        count = count + 1
      end
    end

    def _generate_new_lti_user(params)
      lti_user_id = params[:user_id]

      if current_application_instance.anonymous?
        name = "anonymous"
        email = generate_email
      else
        # Generate a name from the LTI params
        name = if params[:lis_person_name_full].present?
                 params[:lis_person_name_full]
               else
                 "#{params[:lis_person_name_given]} #{params[:lis_person_name_family]}"
               end
        name = name.strip
        name = params[:roles] if name.blank? # If the name is blank then use their role

        email = _assemble_email
      end

      user = User.new(email: email, name: name)
      user.skip_confirmation!
      user.password = ::SecureRandom::hex(15)
      user.password_confirmation = user.password
      user.lti_user_id = lti_user_id
      user.lti_provider = lti_provider
      user.lms_user_id = lms_user_id
      user.create_method = User.create_methods[:lti]

      # store lti roles for the user
      _add_roles(user, params)

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
      params["custom_canvas_api_domain"] || Rails.application.secrets.application_main_domain
    end

    def _assemble_email
      # If there isn't an email then we have to make one up. We use the user_id and instance guid
      email = params[:lis_person_contact_email_primary]
      email = "user-#{params[:user_id]}@#{domain_for_email}" if email.blank? && params[:user_id].present?
      # If there isn't an email then we have to make one up. We use the user_id and instance guid
      email = generate_email if email.blank?
      email
    end

    def lti_roles
      params["ext_roles"] || params["roles"]
    end

    def lms_user_id
      params[:custom_canvas_user_id] || params[:user_id]
    end

  end
end
