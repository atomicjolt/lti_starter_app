class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti, except: [:launch]
  after_action :do_caliper

  def index
    if current_application_instance.disabled_at
      render file: File.join(Rails.root, "public", "disabled.html")
    end
    setup_lti_response
  end

  def show
    @lti_launch = LtiLaunch.find_by(token: params[:id], context_id: params[:context_id])
    setup_lti_response
    render :index
  end

  def launch
    @launch_params = Lti::Launch.params(
      current_application_instance.lti_key,
      current_application_instance.lti_secret,
      {
        "launch_url" => lti_launches_url,
        "roles" => "Learner",
      },
    )
  end

  private

  def setup_lti_response
    begin
      @canvas_api = canvas_api
      @canvas_auth_required = @canvas_api.blank?
    rescue Exceptions::CanvasApiTokenRequired
      @canvas_auth_required = true
    end
    set_lti_launch_values
  end

  def do_caliper
    events = Kaliper::LtiUtils.from_lti_1_2(
      application_instance: current_application_instance,
      user: current_user,
      params: params,
    )
    options = Caliper::Options.new
    sensor = Caliper::Sensor.new('https://www.atomicjolt.com/sensors/1', options)
    requestor = Caliper::Request::HttpRequestor.new({
      'host' => "http://learncaliper.herokuapp.com/api/consumer/events/1ebb1f70-5e82-0137-e4ac-4a8f9eeae0c8",
      'auth_token' => "1ebb1f70-5e82-0137-e4ac-4a8f9eeae0c8",
    })
    requestor.send(sensor, events.tool_use_event)
  end

end
