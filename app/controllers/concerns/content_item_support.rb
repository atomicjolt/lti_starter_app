module Concerns
  module ContentItemSupport
    extend ActiveSupport::Concern

    protected

    def generate_content_item_data(
      id,
      content_item_return_url,
      content_item,
      application_instance = current_application_instance
    )
      Lti::ContentItem.generate_content_item_data(id, content_item_return_url, content_item, application_instance)
    end

  end
end
