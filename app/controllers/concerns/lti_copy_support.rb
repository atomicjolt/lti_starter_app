module Concerns
  module LtiCopySupport
    extend ActiveSupport::Concern

    def copy_lti_launch(
      application_instance:,
      lti_launch_id:,
      source_lti_launch_id:,
      secure_token:
    )
      lti_launch = LtiLaunch.find(lti_launch_id)
      source_lti_launch = LtiLaunch.find(source_lti_launch_id)
      source_context = source_lti_launch.lti_context
      if !source_context&.validate_token(secure_token)
        raise Exceptions::InvalidSecureTokenError
      end

      # Copy configuration from the source lti launch to the new one

      lti_launch.update!(
        is_configured: true,
        config: source_lti_launch.config,
        parent: source_lti_launch,
      )
      lti_launch
    end
  end
end
