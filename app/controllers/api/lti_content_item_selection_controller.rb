class Api::LtiContentItemSelectionController < Api::ApiApplicationController

  # ###########################################################
  # Used to generate a content item selection response
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
    @consumer.set_non_spec_param("content_items", params[:content_item])
    render json: @consumer.generate_launch_data
  end

end
