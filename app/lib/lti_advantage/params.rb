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
      contexts = context_claim["type"] || []
      if contexts.include? LtiAdvantage::Definitions::COURSE_CONTEXT
        "COURSE"
      elsif contexts.include? LtiAdvantage::Definitions::ACCOUNT_CONTEXT
        "ACCOUNT"
      else
        "UNKNOWN"
      end
    end

    def context_id
      context_claim["id"]
    end

    def context_label
      context_claim["label"]
    end

    def context_title
      context_claim["title"]
    end

    def context_claim
      token[LtiAdvantage::Definitions::CONTEXT_CLAIM] || {}
    end

    def resource_link_id
      resource_link_claim["id"]
    end

    def resource_link_title
      resource_link_claim["title"]
    end

    def resource_link_claim
      token[LtiAdvantage::Definitions::RESOURCE_LINK_CLAIM] || {}
    end

    def tool_platform_claim
      token[LtiAdvantage::Definitions::TOOL_PLATFORM_CLAIM] || {}
    end

    def deployment_id
      token[LtiAdvantage::Definitions::DEPLOYMENT_ID]
    end

    def resource_link_id_history
      custom_claim["resource_link_id_history"]
    end

    def context_id_history
      custom_claim["context_id_history"]
    end

    def course_id
      value = custom_claim["canvas_course_id"]
      if value != "$Canvas.course.id"
        value
      end
    end

    def account_id
      value = custom_claim["canvas_account_id"]
      if value != "$Canvas.account.id"
        value
      end
    end

    def course_name
      value = custom_claim["canvas_course_name"]
      if value != "$Canvas.course.name"
        value
      end
    end

    # This extracts the custom parameters from the jwt token from the lti launch
    # These values must be added to the developer key under "Custom Fields"
    # for example: canvas_course_id=$Canvas.course.id
    def custom_claim
      token[LtiAdvantage::Definitions::CUSTOM_CLAIM] || {}
    end
  end
end
