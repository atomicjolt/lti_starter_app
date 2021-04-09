class Api::LtiContentItemSelectionController < Api::ApiApplicationController

  include ContentItemSupport
  # ###########################################################
  # Used to generate a content item selection response
  def create
    render json: generate_content_item_data("fake_id", params[:content_item_return_url], params[:content_item])
  end

end
