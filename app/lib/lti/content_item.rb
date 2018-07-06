module Lti
  class ContentItem
    def self.embed_iframe(src, height = "500")
      iframe = %{<iframe style="width:100%;height:#{height}px;" src="#{src}"></iframe>}
      [{
        "@type": "ContentItem",
        mediaType: "text/html",
        text: iframe,
        placementAdvice: {
          presentationDocumentTarget: "embed",
        },
      }]
    end

    def self.embed_lti_iframe(id, url, height = "500")
      [{
        "@type": "LtiLinkItem",
        "@id": id,
        mediaType: "application/vnd.ims.lti.v1.ltilink",
        url: url,
        placementAdvice: {
          display_width: "100%",
          display_height: "#{height}px",
          presentationDocumentTarget: "iframe",
        },
      }]
    end

    def self.generate_content_item_data(_id, content_item_return_url, content_item, application_instance)
      message = IMS::LTI::Models::Messages::ContentItemSelection.new(
        content_items: content_item,
      )
      message.lti_version = "LTI-1p0"
      message.launch_url = content_item_return_url
      message.oauth_consumer_key = application_instance.lti_key
      message.signed_post_params(application_instance.lti_secret)
    end

    def self.canvas_assignment_url(lms_assignment_id, lms_course_id, application_instance)
      "#{application_instance.site.url}/courses/#{lms_course_id}/assignments/#{lms_assignment_id}?display=borderless"
    end
  end
end
