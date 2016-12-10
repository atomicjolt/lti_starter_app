class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_lti_application_instance

  protected

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: exception.message }
      format.json { render json: { error: exception.message }, status: :unauthorized }
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

    def current_lti_application_instance
      @current_lti_application_instance ||= LtiApplicationInstance.find_by(lti_key: params[:oauth_consumer_key])
    end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def user_not_authorized
    respond_to do |format|
      format.html { render file: "public/401.html", status: :unauthorized }
      format.json { render json: { }, status: :unauthorized }
    end
  end

end
