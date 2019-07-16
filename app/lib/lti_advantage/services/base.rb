module LtiAdvantage
  module Services
    class Base

      def initialize(application_instance, lti_token)
        @application_instance = application_instance
        @lti_token = lti_token
      end

      def headers(options = {})
        @token ||= LtiAdvantage::Authorization.request_token(@application_instance, @lti_token)
        {
          "Authorization" => "Bearer #{@token['access_token']}",
        }.merge(options)
      end

    end
  end
end
