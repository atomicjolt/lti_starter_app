class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_application_instance,
                :current_bundle_instance,
                :current_canvas_course,
                :canvas_url,
                :targeted_app_instance,
                :current_user_roles

  protected

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.json { render json: { error: exception.message }, status: :unauthorized }
    end
  end

  rescue_from LMS::Canvas::RefreshTokenRequired do |exception|
    # Auth has gone bad. Remove it and request that the user do OAuth
    auth = Authentication.find(exception.auth.id)
    user = auth.user
    auth.destroy
    if current_application_instance.oauth_precedence.include?("user") || # The application allows for user tokens
        current_user == user # User owns the authentication. We can ask them to refresh
      respond_to do |format|
        format.json { render json: { message: "canvas_authorization_required" }, status: :forbidden }
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Unable to find Canvas API Token." }, status: :forbidden }
      end
    end
  end

  def canvas_url
    @canvas_url ||= session[:canvas_url] ||
      current_application_instance&.site&.url ||
      current_bundle_instance&.site&.url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def current_application_instance
    @current_application_instance ||=
      ApplicationInstance.find_by(lti_key: params[:oauth_consumer_key]) ||
      ApplicationInstance.find_by(domain: request.host_with_port) ||
      ApplicationInstance.find_by(id: params[:application_instance_id])
  end

  def current_canvas_course
    @canvas_course ||=
      CanvasCourse.
        where(lms_course_id: params[:custom_canvas_course_id]).
        or(CanvasCourse.where(lms_course_id: params[:lms_course_id])).
        first
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

  def user_not_authorized
    respond_to do |format|
      format.html { render file: "public/401.html", status: :unauthorized }
      format.json { render json: {}, status: :unauthorized }
    end
  end

  def set_lti_launch_values
    @is_lti_launch = true
    @canvas_url = current_application_instance.site.url
    @app_name = current_application_instance.application.client_application_name
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
