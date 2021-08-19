class LtiLaunchesController < ApplicationController
  include CanvasSupport
  include LtiSupport
  include OpenIdConnectSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti, except: [:init, :launch]

  def index
    if current_application_instance.disabled_at
      render file: File.join(Rails.root, "public", "disabled.html")
    end

    if @lti_token
      # LTI advantage example code
      @lti_advantage_examples = LtiAdvantage::Examples.new(@lti_token, current_application_instance)
      @lti_advantage_examples.run

      if params[:lti_launch_token].present?
        @lti_launch = LtiLaunch.find_by(
          token: params[:lti_launch_token],
          context_id: @lti_token[LtiAdvantage::Definitions::CONTEXT_CLAIM]["id"],
        )

        set_lti_launch_resource_link_id
      end
    end

    setup_lti_response
  end

  def show
    @lti_launch = LtiLaunch.find_by(token: params[:id], context_id: params[:context_id])
    set_lti_launch_resource_link_id
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
    state = LtiAdvantage::OpenId.state
    url = build_response(state, params, nonce)
    cookies[:open_id_state] = state
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

  def set_lti_launch_resource_link_id
    return unless @lti_launch
    return if @lti_launch.resource_link_id.present?

    if @lti_token && @lti_token[LtiAdvantage::Definitions::RESOURCE_LINK_CLAIM].present?
      @lti_launch.update(resource_link_id: @lti_token[LtiAdvantage::Definitions::RESOURCE_LINK_CLAIM]["id"])
    elsif params[:resource_link_id].present?
      @lti_launch.update(resource_link_id: params[:resource_link_id])
    end
  end
end
