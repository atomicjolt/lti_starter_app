class Api::LtiLaunchesController < Api::ApiApplicationController

  include Concerns::ContentItemSupport

  load_and_authorize_resource :lti_launch

  before_action :set_configs, only: [:create]

  def create
    @lti_launch.save!
    result = {
      lti_launch: @lti_launch,
    }
    if content_item = params[:content_item].to_json

      # HACK. We are replacing path directly in the json
      content_item.gsub!("/lti_launches", "/lti_launches/#{@lti_launch.token}")

      content_item_data = generate_content_item_data(
        @lti_launch.token,
        params[:content_item_return_url],
        content_item,
      )

      result[:content_item_data] = content_item_data
    end

    render json: result
  end

  private

  def set_configs
    # Strong params doesn't allow arbitrary json to be permitted
    # So we have to explicitly set the config
    # This will be allowed in rails 5.1
    @lti_launch.config = params[:lti_launch][:config]
  end

  def lti_launch_params
    params.require(:lti_launch).permit(
      :config,
    )
  end

end
