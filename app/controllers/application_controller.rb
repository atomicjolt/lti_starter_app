class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_rollbar_scope

  helper_method :current_application_instance,
                :current_bundle_instance,
                :current_canvas_course,
                :canvas_url,
                :targeted_app_instance,
                :current_user_roles

  protected

  def render_error(status, message, json_options = {})
    respond_to do |format|
      format.html { render file: "public/#{status}.html", status: status }
      format.json do
        render json: {
          message: message,
        }.merge(json_options), status: status
      end
    end
  end

  def invalid_request(message)
    render_error 400, message
  end

  def user_not_authorized(message = "")
    render_error 401, message
  end

  def record_exception(exception)
    Rollbar.error(exception) if current_application_instance.rollbar_enabled?
    Rails.logger.error "Unexpected exception during execution"
    Rails.logger.error "#{exception.class.name} (#{exception.message}):"
    Rails.logger.error "  #{exception.backtrace.join("\n  ")}"
  end

  # NOTE: Exceptions are specified in order of most general at the top with more specific at the bottom

  # Exceptions defined in order of increasing specificity.
  rescue_from Exception, with: :internal_error
  def internal_error(exception)
    record_exception(exception)
    render_error 500, "Internal error: #{exception.message}"
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def not_found
    render_error 404, "Unable to find the requested record"
  end

  rescue_from CanCan::AccessDenied, with: :permission_denied
  def permission_denied(exception = nil)
    message = exception.present? ? exception.message : "Permission denied"
    render_error 403, message
  end

  # Handle other Canvas related exceptions
  rescue_from LMS::Canvas::CanvasException, with: :handle_canvas_exception
  def handle_canvas_exception(exception)
    record_exception(exception)
    render_error 500, "Error while accessing Canvas: #{exception.message}.", { exception: exception }
  end

  # Raised when a new token cannot be retrieved using the refresh token
  rescue_from LMS::Canvas::RefreshTokenFailedException, with: :handle_canvas_token_expired

  # Raised if a refresh token or its options are not available
  rescue_from LMS::Canvas::RefreshTokenRequired, with: :handle_canvas_token_expired
  def handle_canvas_token_expired(exception)
    # Auth has gone bad. Remove it and request that the user do OAuth
    user = nil
    if auth = Authentication.find_by(id: exception.auth&.id)
      user = auth.user
      auth.destroy
    end
    json_options = {}
    if current_application_instance.oauth_precedence.include?("user") || # The application allows for user tokens
        current_user == user # User owns the authentication. We can ask them to refresh
      json_options = {
        canvas_authorization_required: true,
      }
    end
    render_error 401, "Canvas API Token has expired.", json_options
  end

  # Raised when no Canvas token is available
  rescue_from Exceptions::CanvasApiTokenRequired, with: :handle_canvas_token_required
  def handle_canvas_token_required(exception)
    json_options = {
      exception: exception,
      canvas_authorization_required: true,
    }
    render_error 401, "Unable to find valid Canvas API Token.", json_options
  end

  rescue_from LMS::Canvas::InvalidAPIRequestFailedException, with: :handle_invalid_canvas_api_request
  def handle_invalid_canvas_api_request(exception)
    json_options = {
      exception: exception,
      backtrace: exception.backtrace,
    }
    render_error 500, "An error occured when calling the Canvas API: #{exception.message}", json_options
  end

  def set_rollbar_scope
    if !current_application_instance.rollbar_enabled?
      Rollbar.configure { |config| config.enabled = false }
    end
    Rollbar.scope!(
      tenant: Apartment::Tenant.current,
    )
  end

  def canvas_url
    @canvas_url ||= session[:canvas_url] ||
      custom_canvas_api_domain ||
      current_application_instance&.site&.url ||
      current_bundle_instance&.site&.url
  end

  def custom_canvas_api_domain
    if params[:custom_canvas_api_domain].present?
      "https://#{params[:custom_canvas_api_domain]}"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_application_instance
    @current_application_instance ||=
      LtiAdvantage::Authorization.application_instance_from_token(request.params["id_token"]) ||
      ApplicationInstance.find_by(lti_key: Lti::Request.oauth_consumer_key(request)) ||
      ApplicationInstance.find_by(domain: request.host_with_port) ||
      ApplicationInstance.find_by(id: params[:application_instance_id])
  end

  def current_canvas_course
    lms_course_id = params[:custom_canvas_course_id] || params[:lms_course_id]
    @canvas_course ||= CanvasCourse.find_by(lms_course_id: lms_course_id)
  end

  def current_application
    Application.find_by(key: request.subdomains.first)
  end

  def current_bundle_instance
    @current_bundle ||= BundleInstance.
      where(id_token: params[:bundle_instance_token]).
      or(BundleInstance.where(id: params[:bundle_instance_id])).
      first
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, params[:context_id])
  end

  def current_user_roles(context_id: nil)
    current_user.nil_or_context_roles(context_id).map(&:name)
  end

  def set_lti_launch_values
    @is_lti_launch = true
    @canvas_url = current_application_instance.site.url
    @app_name = current_application_instance.application.client_application_name
  end

  def set_lti_advantage_launch_values
    @lti_token = LtiAdvantage::Authorization.validate_token(
      current_application_instance,
      params[:id_token],
    )
    @lti_params = LtiAdvantage::Params.new(@lti_token)
    @lti_launch_config = JSON.parse(params[:lti_launch_config]) if params[:lti_launch_config]
    @is_deep_link = true if LtiAdvantage::Definitions.deep_link_launch?(@lti_token)
    @app_name = current_application_instance.application.client_application_name
    @title = current_application_instance.application.name
    @description = current_application_instance.application.description
  end

  def targeted_app_instance
    key = request.subdomains.first
    application = Application.find_by(key: key)
    return nil if current_bundle_instance.nil?
    current_bundle_instance.
      application_instances.
      find_by(application_id: application.id)
  end

end
