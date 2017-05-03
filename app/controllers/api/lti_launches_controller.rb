class Api::LtiLaunchesController < Api::ApiApplicationController

  include Concerns::ContentItemSupport

  def create
    lti_launch = LtiLaunch.create!(lti_launch_params)

    result = {
      lti_launch: lti_launch,
    }

    if content_item = params[:content_item]

      content_item.gsub!(lti_launches_url, lti_launch_url(lti_launch.token))

      content_item_data = generate_content_item_data(
        lti_launch.token,
        params[:content_item_return_url],
        content_item,
      )

      result[:content_item_data] = content_item_data
    end

    render json: result
  end

  protected

  def lti_launch_params
    params.require(:lti_launch).permit(:config)
  end

end
