module Concerns
  module LtiSupport
    extend ActiveSupport::Concern

    included do
      helper_method :lti_provider
    end

    protected

    def do_lti
      if valid_lti_request?(current_application_instance.lti_key, current_application_instance.lti_secret)
        if user = user_from_lti
          sign_in(user, event: :authentication)
          return
        end
      end
      user_not_authorized
    end

    def valid_lti_request?(lti_key, lti_secret)
      @tool_provider = IMS::LTI::ToolProvider.new(lti_key, lti_secret, params)
      @tool_provider.valid_request?(request) &&
        Nonce.valid?(@tool_provider.oauth_nonce) &&
        valid_timestamp?(@tool_provider.oauth_timestamp)
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
      user = User.find_by(lti_provider: lti_provider, lti_user_id: lti_user_id)

      if user.blank?
        domain = params["custom_canvas_api_domain"] || Rails.application.secrets.application_main_domain
        user = _generate_new_lti_user(params)
        _attempt_uniq_email(user, domain)
      else
        _update_roles(user, params)
      end

      user
    end

    private

    def valid_timestamp?(timestamp)
      Time.at(timestamp.to_i) >= (Time.now - 1.hour)
    end

    def generate_email(domain)
      "generated-#{User.maximum(:id).next}@#{domain}"
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

    def _attempt_uniq_email(user, domain)
      count = 0 # don't go infinite
      while !safe_save_email(user) && count < 10
        user.email = generate_email(domain)
        count = count + 1
      end
    end

    def _generate_new_lti_user(params)
      lti_user_id = params[:user_id]
      # Generate a name from the LTI params
      name = if params[:lis_person_name_full].present?
               params[:lis_person_name_full]
             else
               "#{params[:lis_person_name_given]} #{params[:lis_person_name_family]}"
             end
      name = name.strip
      name = params[:roles] if name.blank? # If the name is blank then use their role

      email = _assemble_email

      user = User.new(email: email, name: name)
      user.password = ::SecureRandom::hex(15)
      user.password_confirmation = user.password
      user.lti_user_id = lti_user_id
      user.lti_provider = lti_provider
      user.lms_user_id = params[:custom_canvas_user_id] || params[:user_id]
      user.create_method = User.create_methods[:oauth]
      user.skip_confirmation!

      # store lti roles for the user
      _add_roles(user, params)

      user
    end

    def _add_roles(user, params)
      all_roles = (params["ext_roles"] || params["roles"]).split(",")
      # Only store roles that start with urn:lti:role to prevent using local roles
      roles = all_roles.select { |role| role.start_with?("urn:lti:") }
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

    def _assemble_email
      # If there isn't an email then we have to make one up. We use the user_id and instance guid
      domain = params["custom_canvas_api_domain"] || Rails.application.secrets.application_main_domain
      email = params[:lis_person_contact_email_primary]
      email = "user-#{params[:user_id]}@#{domain}" if email.blank? && params[:user_id].present?
      # If there isn't an email then we have to make one up. We use the user_id and instance guid
      email = generate_email(domain) if email.blank?
      email
    end

  end
end
