module Concerns
  module ContentItemSupport
    extend ActiveSupport::Concern

    protected

    def generate_content_item_data(id, content_item_return_url, content_item)
      message = IMS::LTI::Models::Messages::ContentItemSelection.new(
        content_items: content_item,
      )
      message.lti_version = "LTI-1p0"
      message.launch_url = content_item_return_url
      message.oauth_consumer_key = current_application_instance.lti_key
      message.signed_post_params(current_application_instance.lti_secret)
    end

  end
end
