module LtiAdvantage
  class LtiUser
    def initialize(lti_token, application_instance)
      @lti_token = lti_token
      @application_instance = application_instance
      @lti_user_id = lti_token["sub"]
    end

    def user
      user = ::User.find_by(lti_user_id: @lti_user_id)
      user = _migrate_lti_user if user.blank?

      if user.blank?
        user = _generate_new_lti_user
      else
        if _lms_user_id.present?
          user.lms_user_id = _lms_user_id
        end
        if _legacy_lti11_user_id.present?
          user.legacy_lti_user_id = _legacy_lti11_user_id
        end
        _update_roles(user)
      end
      user.save!

      user
    end

    def name
      return "anonymous" if @application_instance.anonymous?

      @lti_token["name"].presence ||
        "#{@lti_token['given_name']} #{@lti_token['family_name']}".presence || email
    end

    def email
      @email ||= _generate_email
    end

    # If a LTI 1.1 install is being migrated to an Advantage install,
    # pre-existing users won't be found correctly. So we swap out their
    # lti id with their new lti_user_id before proceeding
    #
    # Note: There is a case in Canvas where migration will fail:
    #
    # 1. User A is in course C and has launched into this tool with LTI 1.1 in C
    # 2. User A is then merged into a user B
    # 3. User B launches with lti 1.3
    #
    # At this point we will start to see B's LTI legacy user id, and not A's old legacy user id.
    # Instead we would expect to continue to see A's old legacy user id in course C launches.
    # This appears to be a bug in Canvas and we don't have a good workaround.
    #
    def _migrate_lti_user
      return if _legacy_lti11_user_id.blank?

      user = User.find_by(lti_user_id: _legacy_lti11_user_id)
      if user
        user.lti_user_id = @lti_user_id
      end
      user
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
      user.legacy_lti_user_id = _legacy_lti11_user_id

      # store lti roles for the user
      _add_roles(user)

      user
    end

    def _add_roles(user)
      roles = @lti_token[AtomicLti::Definitions::ROLES_CLAIM]
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

      roles_names = permissions.includes(:role).map { |per| per.role&.name }.compact
      diff = roles_names - roles
      # If the user has context roles that no longer are sent from canvas,
      # then delete them.
      if diff.present?
        to_delete = permissions.joins(:role).where(roles: { name: diff })
        to_delete.destroy_all
      end
    end

    def _generate_email
      "generated-#{::SecureRandom::hex(10)}@#{_domain_for_email}"
    end

    def _domain_for_email
      _lti_provider ||
        @lti_token.dig(AtomicLti::Definitions::CUSTOM_CLAIM, "canvas_api_domain") ||
        Rails.application.secrets.application_main_domain
    end

    def _lms_user_id
      # lms_user_id should match the identifier we get from the rostering service.
      # For canvas that's the canvas_user_id. For Lti Advantage it's the lti_user_id
      if @application_instance.use_canvas_api?
        @lti_token.dig(AtomicLti::Definitions::CUSTOM_CLAIM, "canvas_user_id")
      else
        @lti_user_id
      end
    end

    def _legacy_lti11_user_id
      @lti_token[AtomicLti::Definitions::LTI11_LEGACY_USER_ID_CLAIM]
    end

    def _lti_provider
      AtomicLti::Definitions.lms_host(@lti_token)
    end

    def _context_id
      @lti_token.dig(AtomicLti::Definitions::CONTEXT_CLAIM, "id")
    end

  end
end
