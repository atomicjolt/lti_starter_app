class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Concerns::LtiSupport

  before_action :verify_oauth_response, except: [:passthru]
  before_action :login_canvas_lti_user
  before_action :associated_using_oauth, except: [:passthru]
  before_action :find_using_oauth, except: [:passthru]
  before_action :create_using_oauth, except: [:passthru]

  def passthru
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  def canvas
    canvas_url = request.env["canvas.url"] || params["canvas_url"] || session[:canvas_url]
    canvas_url = UrlHelper.scheme_host_port(canvas_url.strip)

    if @user.lti_provider.blank?
      auth = @user.authentications.find_by(provider_url: canvas_url, provider: "canvas")
      @user.lti_provider = UrlHelper.host(auth["provider_url"])
      @user.lms_user_id = auth.uid
    end

    @user.save!
    @canvas_auth_required = false

    admin_oauth_aii = params["admin_oauth_aii"]
    if admin_oauth_aii.present? && ai = application_instance(admin_oauth_aii)
      # brakeman doesn't like redirecting based on user input.
      # this finds an app instance by the id passed in to it and redirects to a
      # predefined url.
      root_domain = Rails.application.secrets.application_root_domain
      path = "applications/#{ai.application_id}/application_instances/#{ai.id}/installs"
      oauth_complete_url = "//#{Application::ADMIN}.#{root_domain}#{admin_root_path}##{path}"
      redirect_to oauth_complete_url
    else
      set_lti_launch_values if params[:oauth_consumer_key].present?
      set_lti_advantage_launch_values if params[:id_token].present?
      render "lti_launches/index", layout: "client"
    end
  end

  protected

  def application_instance(id)
    ApplicationInstance.find(id)
  end

  # This will ensure that a user previously logged in via LTI will
  # still be logged in after the OAuth Dance with Canvas
  def login_canvas_lti_user
    return true if user_signed_in?
    auth = request.env["omniauth.auth"]
    if auth["provider"].downcase == "canvas" && lti_user_id = User.oauth_lti_user_id(auth)
      if @user = User.find_by(lti_user_id: lti_user_id)
        sign_in_or_register("Canvas")
      end
    end
  end

  def redirect_params
    params.permit(:error)
  end

  def verify_oauth_response
    # Check for OAuth errors
    return if request.env["omniauth.auth"].present?

    if oauth_state = OauthState.find_by(state: request.params["state"])
      oauth_state.destroy
    end

    flash.discard
    flash[:error] = format_oauth_error_message(oauth_error_message)
    render "shared/_omniauth_error", status: :forbidden
  end

  def oauth_error_message
    # Keep these and use them for debugging omniauth.
    # exception = request.env['omniauth.error']
    # error_type = request.env['omniauth.error.type']
    # strategy = request.env['omniauth.error.strategy']
    # exception.error_reason
    error_type = request.env["omniauth.error.type"]
    if request.env["omniauth.strategy"].present? && request.env["omniauth.strategy"].name.present?
      %{
        There was a problem communicating with #{request.env['omniauth.strategy'].name.titleize}.
        Error: #{error_type} - #{request.env['omniauth.error'].error_reason}
      }
    else
      "There was a problem communicating with the remote service. Error: #{error_type}"
    end
  end

  def format_oauth_error_message(error)
    if request.env["omniauth.strategy"]&.name == "canvas"
      error
    else
      %{#{error} If this problem persists try signing up with a different service
        or create an #{Rails.application.secrets.application_name} account with
        just an email and password.
      }.html_safe
    end
  end

  def associated_using_oauth
    # Used at the profile#edit to integrated other networks to the same account
    if user_signed_in?
      @user = current_user
      auth = request.env["omniauth.auth"]
      kind = params[:action].titleize # Should give us Facebook, Twitter, Linked In, etc
      authentication = current_user.associate_account(auth)
      current_user.save!
      flash[:notice] = "Your #{Rails.application.secrets.application_name} account has been associated with #{kind}"
      redirect_to after_sign_in_path_for(current_user) if should_redirect?
    end
  rescue ActiveRecord::RecordInvalid => ex
    message = error_message(ex, auth, authentication)
    flash[:error] = %{
      Your #{Rails.application.secrets.application_name} account could not be associated with this account: #{message}
    }.html_safe
    redirect_to after_sign_in_path_for(current_user)
  end

  def error_message(ex, auth, authentication)
    if authentication
      if !authentication.errors[:provider].empty?
        user_link = "user"
        if previous_authentication = Authentication.find_by(provider: auth["provider"], uid: auth["uid"])
          user_link = %{
            <a href="#{user_profile_path(previous_authentication.user)}">
              #{previous_authentication.user.display_name}
            </a>
          }
        end
        message = %{
          Another #{Rails.application.secrets.application_name} account: #{user_link}
          has already been associated with the specified #{auth['provider']} account.
        }
      else
        message = authentication.errors.full_messages.join("<br />")
      end
    else
      message = ex.to_s
    end
    message
  end

  def find_using_oauth
    return if @user # Previous filter was successful and we already have a user
    if @user = User.for_auth(request.env["omniauth.auth"])
      @user.skip_confirmation!
      kind = params[:action].titleize
      @user.update_oauth(request.env["omniauth.auth"])
      if kind == "Canvas"
        @user.add_to_role("canvas_oauth_user")
      end
      @user.save # do we want to log an error if save fails?
      sign_in_or_register(kind)
    end
  end

  def create_using_oauth
    return if @user # Previous filter was successful and we already have a user
    auth = request.env["omniauth.auth"]
    kind = params[:action].titleize # Should give us Facebook, Twitter, Linked In, etc
    @user = User.new
    @user.skip_confirmation!
    @user.password = Devise.friendly_token(72)
    @user.password_confirmation = @user.password
    @user.create_method = User.create_methods[:oauth]
    @user.lti_user_id = auth["extra"]["raw_info"]["lti_user_id"]
    @user.apply_oauth(auth)
    if kind == "Canvas"
      @user.add_to_role("canvas_oauth_user")
    end
    @user.save!
    sign_in_or_register(kind)
  rescue ActiveRecord::RecordInvalid => ex
    # A user is already registered with the same email and he tried to sign in
    # using facebook but the account is not connected to facebook.
    if @user.errors[:email].include? I18n.t :taken, scope: [:errors, :messages]
      session[:prompt_setup_service] = kind
      flash[:notice] = "There's already an account with the same email as your #{kind} account.
        Please login first and then connect your #{kind} account to login with #{kind} in the future."
      redirect_to sign_in_url
    # Sign up from social networks without email (twitter and linkedin)
    elsif @user.errors[:email].include? I18n.t :blank, scope: [:errors, :messages]
      session["devise.omniauth_data"] = auth
      flash[:notice] = "Please add an email to associate with this account"
      redirect_to new_user_registration_url
    else
      raise ex
    end
  end

  def sign_in_or_register(kind)
    sign_in(@user, event: :authentication)
    if should_redirect?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: kind
      redirect_to after_sign_in_path_for(@user)
    end
  end

  def should_redirect?
    return false if ["canvas"].include?(params[:action]) # Don't redirect we need to do more configuration
    true
  end
end
