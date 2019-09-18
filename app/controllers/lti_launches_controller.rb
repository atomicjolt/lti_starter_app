class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport
  include Concerns::OpenIdConnectSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti, except: [:init, :launch]

  def index
    if current_application_instance.disabled_at
      render file: File.join(Rails.root, "public", "disabled.html")
    end

    # LTI advantage example code
    if @lti_token
      @lti_advantage_examples = LtiAdvantage::Examples.new(@lti_token, current_application_instance)
      @lti_advantage_examples.run
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

  # Support Open ID connect flow for LTI 1.3
  def init
    nonce = SecureRandom.hex(64)
    url = build_response(LtiAdvantage::OpenId.state, params, nonce)
    respond_to do |format|
      format.html { redirect_to url }
    end
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

end
