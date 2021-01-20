class LtiLaunchesController < ApplicationController
  include Concerns::CanvasSupport
  include Concerns::LtiSupport
  include Concerns::OpenIdConnectSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :do_lti, except: [:init, :launch]

  def index
    # This is an LTI 1.2 launch with no launch token, or an LTI 1.3
    # launch.
    if current_application_instance.disabled_at
      render file: File.join(Rails.root, "public", "disabled.html")
    end

    if @lti_token
      # LTI 1.3
      token = lti_advantage_launch_token
      if token
        @lti_launch = LtiLaunch.lti_advantage_launch(
          token: token,
          lti_params: LtiAdvantage::Params.new(@lti_token),
          application_instance: current_application_instance,
        )

        # LTI advantage example code
        @lti_advantage_examples = LtiAdvantage::Examples.new(@lti_token, current_application_instance)
        @lti_advantage_examples.run
      end
    end

    setup_lti_response
  end

  def show
    # This is an LTI 1.2 launch with the token as a path parameter
    token = params[:id]
    @lti_launch = LtiLaunch.lti_launch(
      token: token,
      params: params,
      application_instance: current_application_instance,
    )

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
    url = build_response(
      state: LtiAdvantage::OpenId.state,
      params: params,
      nonce: nonce,
      redirect_uri: lti_launches_url
    )
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

  def lti_advantage_launch_token
    # For LTI advantage, we use the target_link_uri claim to find the token
    uri = URI.parse(@lti_token[LtiAdvantage::Definitions::TARGET_LINK_URI_CLAIM])
    uri_params = Rack::Utils.parse_query(uri.query)

    # Accept token as either query parameter or path parameter
    uri_params[:lti_launch_token] ||
      /^#{Regexp.quote(lti_launches_path)}\/(.+)$/.match(uri.path) { |m| m[1] }
  end
end
