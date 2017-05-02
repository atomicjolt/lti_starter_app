class Api::LtiLaunchesController < Api::ApiApplicationController

  include Concerns::ContentItemSupport

  def create
    lti_launch = LtiLaunch.create!(lti_launch_params)

    # Modify the launch_url in params[:content_item] to include the lti_launch id
    content_item = params[:content_item].gsub("/lti_launches", "/lti_launches/#{lti_launch.id}")

    content_item_data = generate_content_item_data(
      lti_launch.id,
      params[:content_item_return_url],
      content_item,
    )

    render json: {
      lti_launch: lti_launch,
      content_item_data: content_item_data,
    }
  end

  protected

  def lti_launch_params
    params.require(:lti_launch).permit(:config)
  end

end
