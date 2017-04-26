class Api::LtiContentItemSelectionController < Api::ApiApplicationController

  # ###########################################################
  # Used to generate a content item selection response
  # Description of params:
  #   content_item_return_url (required) - the url provided during the initial LTI request.
  #     Post the content item selection request back to this url.
  #   content_item_type (required) - iframe, html or lti_link depending on
  #     the desired type of content to be posted back to the tool consumer
  #   content_item_url - Required if content_item_type is iframe or lti_link.
  #     This is the LTI launch url.
  #   content_item_html - for content_item_type == html. This is the html
  #     that will be embedded into the page
  #   content_item_name - for content_item_type == lti_link. The name of the link.
  def index
    @consumer = IMS::LTI::ToolConsumer.new(
      current_application_instance.lti_key,
      current_application_instance.lti_secret,
    )
    tc = IMS::LTI::ToolConfig.new(launch_url: params[:content_item_return_url])
    @consumer.set_config(tc)
    # TODO maybe generate an lti launch object that can contain a json
    # object with details about how to do the lti launch
    @consumer.resource_link_id = "f_id"
    @consumer.lti_message_type = "ContentItemSelection"
    @consumer.set_non_spec_param("content_items", content_item_hash(content).to_json)

    render json: @consumer.generate_launch_data
  end

  protected

  def content_item_hash(content)
    {
      "@context" => "http://purl.imsglobal.org/ctx/lti/v1/ContentItem",
      "@graph" => content,
    }
  end

  def content
    if params[:content_item_type] == "iframe"
      embed_iframe(params[:content_item_url])
    elsif params[:content_item_type] == "html"
      embed(params[:content_item_html])
    elsif params[:content_item_type] == "lti_link"
      lti_launch(params[:content_item_name], params[:content_item_url])
    end
  end

  def embed(html)
    [
      {
        "@type" => "ContentItem",
        "mediaType" => "text/html",
        "text" => html,
        "placementAdvice" => {
          "presentationDocumentTarget" => "embed",
        },
      },
    ]
  end

  def lti_launch(name, launch_url)
    [
      {
        "@type" => "LtiLinkItem",
        "mediaType" => "application/vnd.ims.lti.v1.ltilink",
        "url" => launch_url,
        "title" => name,
      },
      {
        "@type" => "LtiLinkItem",
        "mediaType" => "application/vnd.ims.lti.v1.ltilink",
        "url" => launch_url,
        "title" => name,
        "text" => name,
        "lineItem" => {
          "@type" => "LineItem",
          "label" => name,
          "reportingMethod" => "res:totalScore",
          "maximumScore" => 10,
          "scoreConstraints" => {
            "@type" => "NumericLimits",
            "normalMaximum" => 10,
            "totalMaximum" => 10,
          },
        },
      },
    ]
  end

  def embed_iframe(iframe_url)
    iframe = <<-HTML
      <iframe style="width: 100%; height: 500px;" src="#{iframe_url}">
      </iframe>
    HTML

    [
      {
        "@type" => "ContentItem",
        "mediaType" => "text/html",
        "text" => iframe,
        "placementAdvice" => {
          "presentationDocumentTarget" => "embed",
        },
      }
    ]
  end

end
