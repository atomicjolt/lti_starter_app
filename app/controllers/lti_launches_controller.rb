class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport

  layout "client"

  skip_before_filter :verify_authenticity_token
  before_action :do_lti

  def index
    @canvas_api = canvas_api
    @canvas_auth_required = @canvas_api.blank?

    @lti_launch = true

    @canvas_oauth_path = user_canvas_omniauth_authorize_url(
      oauth_consumer_key: params[:oauth_consumer_key],
      canvas_url: current_lti_application_instance.lti_consumer_uri,
      out_of_band: true
    )
  end
end
