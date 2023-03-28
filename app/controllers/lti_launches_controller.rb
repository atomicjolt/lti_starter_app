class LtiLaunchesController < ApplicationController
  include CanvasSupport
  include LtiSupport

  layout "client"

  skip_before_action :verify_authenticity_token
  before_action :debug_data
  before_action :check_disabled
  before_action :do_lti
  before_action :set_lti_launch_values

  def index
    if current_application_instance.disabled_at
      render file: File.join(Rails.root, "public", "disabled.html")
    end

    if @lti_token
      # LTI advantage example code
      @lti_advantage_examples = AtomicLti::Examples.new(@lti_token, current_application_instance)
      @lti_advantage_examples.run

      if params[:lti_launch_token].present?
        @lti_launch = LtiLaunch.find_by(
          token: params[:lti_launch_token],
          context_id: @lti_token[AtomicLti::Definitions::CONTEXT_CLAIM]["id"],
        )

        set_lti_launch_resource_link_id
      end
    end

    check_canvas_auth
  end

  def show
    @lti_launch = LtiLaunch.find_by(token: params[:id], context_id: params[:context_id])
    set_lti_launch_resource_link_id
    check_canvas_auth

    render :index
  end

  private

  def debug_data
    @debug_data = {
      "Tenant Name" => Apartment::Tenant.current,
      "LTI Advantage" => !!@lti_token,
      "App Name" => current_application&.name,
      "Client App" => current_application&.client_application_name,
      "LTI Key" => current_application_instance&.lti_key,
      "Domain" => current_application_instance&.domain,
    }
  end

  def check_canvas_auth
    return if lti.product_family_code != "canvas"

    begin
      @canvas_api = canvas_api
      @canvas_auth_required = @canvas_api.blank?
    rescue Exceptions::CanvasApiTokenRequired
      @canvas_auth_required = true
    end
  end

  def set_lti_launch_resource_link_id
    return unless @lti_launch
    return if @lti_launch.resource_link_id.present?

    if @lti_token && @lti_token[AtomicLti::Definitions::RESOURCE_LINK_CLAIM].present?
      @lti_launch.update(resource_link_id: @lti_token[AtomicLti::Definitions::RESOURCE_LINK_CLAIM]["id"])
    elsif params[:resource_link_id].present?
      @lti_launch.update(resource_link_id: params[:resource_link_id])
    end
  end

  def check_disabled
    if current_application_instance.disabled_at
      redirect_to "/disabled.html"
    end
  end
end
