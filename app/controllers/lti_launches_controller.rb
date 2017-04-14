class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti

  def index
    @canvas_api = canvas_api
    @canvas_auth_required = @canvas_api.blank?
    @lti_launch = true
    @canvas_url = current_application_instance.site.url
  end
end
