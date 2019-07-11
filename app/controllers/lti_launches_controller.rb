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

    # Line item is currently available in production Canvas
    line_item = LtiAdvantage::Services::LineItems.new(current_application_instance, @lti_token)
    line_items = LtiAdvantage::Services::LineItems.new(current_application_instance, @lti_token).list
    @line_items = JSON.parse(line_items.body)

    resource_id = 1
    tag = "lti-advantage"
    found = @line_items.find{ |li| li["tag"] == tag }
    if found
      result = line_item.update(
        found["id"],
        line_item.generate(
          label: "LTI Advantage test item",
          max_score: 10,
          resource_id: resource_id,
          tag: tag,
        )
      )
    else
      result = line_item.create(line_item.generate(
        label: "LTI Advantage test item",
        max_score: 10,
        resource_id: resource_id,
        tag: tag,
      ))
    end

    names_and_roles_service = LtiAdvantage::Services::NamesAndRoles.new(current_application_instance, @lti_token)
    @names_and_roles = names_and_roles_service.list if names_and_roles_service.valid?

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
    nonce = SecureRandom.hex(10)
    state = AuthToken.issue_token({
      state_nonce: nonce,
      params: params.as_json
    })
    url = build_response(state, params, nonce)
    request.cookies[:state] = state
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

