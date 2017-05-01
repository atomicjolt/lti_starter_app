class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti

  def index
    begin
      @canvas_api = canvas_api
      @canvas_auth_required = @canvas_api.blank?
    rescue CanvasApiTokenRequired
      @canvas_auth_required = true
    end
    set_lti_launch_values
    @lti_launch = ClientSetting.find(params[:id]) if params[:id].present?
  end

end
