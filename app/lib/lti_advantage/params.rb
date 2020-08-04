module LtiAdvantage
  # This is for extracting data from the lti jwt in more human-readable ways
  class Params
    attr_reader :token

    def initialize(lti_token)
      @token = lti_token
    end

    def launch_context
      # This is an array, I'm not sure what it means to have more than one
      # value. In courses and accounts there's only one value
      context = context_data["type"][0]

      case context
      when LtiAdvantage::Definitions::COURSE_CONTEXT then "COURSE"
      when LtiAdvantage::Definitions::ACCOUNT_CONTEXT then "ACCOUNT"
      else "UNKNOWN"
      end
    end

    def context_id
      context_data["id"]
    end

    def context_data
      token[LtiAdvantage::Definitions::CONTEXT_CLAIM]
    end

    def course_id
      value = custom_params["canvas_course_id"]
      if value != "$Canvas.course.id"
        value
      end
    end

    def account_id
      value = custom_params["canvas_account_id"]
      if value != "$Canvas.account.id"
        value
      end
    end

    def course_name
      value = custom_params["canvas_course_name"]
      if value != "$Canvas.course.name"
        value
      end
    end

    # This extracts the custom parameters from the jwt token from the lti launch
    # These values must be added to the developer key under "Custom Fields"
    # for example: canvas_course_id=$Canvas.course.id
    def custom_params
      token[LtiAdvantage::Definitions::CUSTOM_CLAIM]
    end
  end
end
