module LtiAdvantage
  class User
    def initialize(lti_token, application_instance)
      @lti_token = lti_token
      @application_instance = application_instance
      @lti_user_id = lti_token["sub"]
    end

    def user
      user = ::User.find_by(lti_user_id: @lti_user_id)
      if user.blank?
        user = _generate_new_lti_user
        _attempt_uniq_email(user)
      else
        if user.lms_user_id.blank? && _lms_user_id.present?
          user.lms_user_id = _lms_user_id
        end
        _update_roles(user)
      end
      user
    end

    def name
      return "anonymous" if @application_instance.anonymous?

      @lti_token["name"] ||
        "#{@lti_token['given_name']} #{@lti_token['family_name']}" ||
        @lti_token["email"]
    end

    def email
      if @application_instance.anonymous?
        _generate_email
      else
        # If there isn't an email then we have to make one up. We use the user_id and instance guid
        email = @lti_token["email"]
        # If there isn't an email then we have to make one up. We use the user_id and instance guid
        email = "generated-user-#{@lti_user_id}@#{_domain_for_email}" if email.blank? && @lti_user_id.present?
        email
      end
    end

    def _generate_new_lti_user
      user = ::User.new(email: email, name: name)
      user.skip_confirmation!
      user.password = ::SecureRandom::hex(15)
      user.password_confirmation = user.password
      user.lti_user_id = @lti_user_id
      user.lti_provider = _lti_provider
      user.lms_user_id = _lms_user_id
      user.create_method = ::User.create_methods[:lti]

      # store lti roles for the user
      _add_roles(user)

      user
    end

    def _add_roles(user)
      roles = @lti_token.dig(LtiAdvantage::Definitions::ROLES_CLAIM)
      roles.each do |role|
        user.add_to_role(role, _context_id)
      end
      roles
    end

    def _update_roles(user)
      roles = _add_roles(user)

      permissions = user.
        permissions.
        where(context_id: _context_id)

      roles_names = permissions.includes(:role).map { |per| per.role.name }
      diff = roles_names - roles
      # If the user has context roles that no longer are sent from canvas,
      # then delete them.
      if diff.present?
        to_delete = permissions.joins(:role).where(roles: { name: diff })
        to_delete.destroy_all
      end
    end

    def _generate_email
      "generated-#{@lti_user_id}@#{_domain_for_email}"
    end

    def _domain_for_email
      _lti_provider ||
        @lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "canvas_api_domain") ||
        Rails.application.secrets.application_main_domain
    end

    def _lms_user_id
      @lti_token.dig(LtiAdvantage::Definitions::CUSTOM_CLAIM, "canvas_user_id")
    end

    def _lti_provider
      LtiAdvantage::Definitions.lms_host(@lti_token)
    end

    def _context_id
      @lti_token.dig(LtiAdvantage::Definitions::CONTEXT_CLAIM)["id"]
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

  end
end
