# Class representing an lti advantage launch inside a controller
#
# When a controller includes the `lti_support` concern, an
# instance of this class will be accessible from the 'lti' property.

module LtiAdvantage
  class LtiAdvantage::Request

    attr_reader :lti_token, :lti_params

    # delegate all other methods to the lti_params class
    delegate_missing_to :@lti_params

    def initialize(request, application_instance)
      @application_instance = application_instance
      @request = request
      @lti_token = validate!
      @lti_params = AtomicLti::Params.new(@lti_token)
    end

    def validate!
      if @request.env["atomic.validated.id_token"].blank?
        raise LtiAdvantage::Exceptions::InvalidToken
      end

      JWT.decode(@request.env["atomic.validated.id_token"], nil, false)[0]
    end

    def user_from_lti
      LtiAdvantage::LtiUser.new(lti_token, @application_instance).user
    end

    def lti_provider
      AtomicLti::Definitions.lms_host(@lti_token)
    end

    def account_launch?
      canvas_account_id && !canvas_course_id
    end

    def lms_course_id
      lms_course_id = custom_data[:lms_course_id].to_s.presence || canvas_course_id

      if lms_course_id.blank?
        # Here we manufacture an lms_course_id to use as an identifier for
        # scoping course resources.
        #
        # We're not including the deployment_id here so that
        # redeploying a tool doesn't lose all resources.
        lms_course_id = "#{iss}##{tool_consumer_instance_guid}##{context_id}"
      end
      lms_course_id
    end

    def canvas_api_domain
      custom_data[:canvas_api_domain]
    end
  end
end
