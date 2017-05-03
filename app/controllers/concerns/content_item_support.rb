module Concerns
  module ContentItemSupport
    extend ActiveSupport::Concern

    protected

    def generate_content_item_data(id, launch_url, content_item)
      @consumer = IMS::LTI::ToolConsumer.new(
        current_application_instance.lti_key,
        current_application_instance.lti_secret,
      )
      tc = IMS::LTI::ToolConfig.new(launch_url: launch_url)
      @consumer.set_config(tc)
      @consumer.resource_link_id = id
      @consumer.lti_message_type = "ContentItemSelection"
      @consumer.set_non_spec_param("content_items", content_item)
      @consumer.generate_launch_data
    end

  end
end
