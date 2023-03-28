module Lti
  # This class extracts data from an lti 1.1 launch in a way similar to lti advantage
  class Params
    attr_reader :token

    def initialize(params)
      @params = params
    end

    def lti_advantage?
      false
    end

    def deployment_id
      nil
    end

    def version
      @params["lti_version"]
    end

    def context_data
      @context_data ||= group_params("context_")
    end

    def launch_context
      "UNKNOWN"
    end

    def context_id
      context_data[:id]
    end

    def resource_link_data
      @resource_link_data ||= group_params("resource_link_")
    end

    def resource_link_title
      resource_link_data[:title]
    end

    def tool_platform_data
      @tool_platform_data ||= group_params("tool_consumer_info_")
    end

    def product_family_code
      tool_platform_data[:product_family_code]
    end

    def tool_consumer_instance_data
      @tool_consumer_instance_data ||= group_params("tool_consumer_instance_")
    end

    def tool_consumer_instance_guid
      tool_consumer_instance_data[:guid]
    end

    def tool_consumer_instance_name
      tool_consumer_instance_data[:name]
    end

    def launch_presentation_data
      @launch_presentation ||= group_params("launch_presentation_")
    end

    def launch_locale
      launch_presentation_data[:locale]
    end

    def is_deep_link
      false
    end

    # This extracts the custom parameters from the jwt token from the lti launch
    # These values must be added to the developer key under "Custom Fields"
    # for example: canvas_course_id=$Canvas.course.id
    def custom_data
      @custom_data ||= group_params("custom_")
    end

    def canvas_course_id
      filter_canvas_param custom_data[:canvas_course_id]

    end

    def canvas_section_ids
      filter_canvas_param custom_data[:canvas_section_ids]
    end

    def canvas_account_id
      filter_canvas_param custom_data[:canvas_account_id]
    end

    def canvas_course_name
      filter_canvas_param custom_data[:canvas_course_name]
    end

    def canvas_assignment_id
      filter_canvas_param custom_data[:canvas_assignment_id]
    end

    private

    def group_params(prefix)
      @params.map do |key, value|
        if key.start_with?(prefix)
          [key.delete_prefix(prefix), value]
        end
      end.compact.to_h.with_indifferent_access
    end

    def filter_canvas_param(value)
      value unless value&.to_s&.start_with?("$Canvas")
    end
  end
end
