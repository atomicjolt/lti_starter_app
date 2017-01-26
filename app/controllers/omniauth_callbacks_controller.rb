class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Concerns::LtiSupport

  before_filter :verify_oauth_response, except: [:passthru]
  before_filter :associated_using_oauth, except: [:passthru]
  before_filter :find_using_oauth, except: [:passthru]
  before_filter :create_using_oauth, except: [:passthru]

  def passthru
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end

  def canvas
    canvas_url = env["canvas.url"] || params["canvas_url"] || session[:canvas_url]

    canvas_url.strip!

    if @user.lti_provider.blank?
      auth = @user.authentications.find_by(provider_url: canvas_url, provider: "canvas")
      json = Yajl::Parser.parse(auth["json_response"])
      @user.lti_provider = UrlHelper.host(json["info"]["url"])
      @user.lms_user_id = auth.uid
    end

    @user.save!

    @lti_launch = true
    @canvas_oauth_path = user_canvas_omniauth_authorize_url
    @canvas_url = current_application_instance.site.url
    @canvas_auth_required = false

    if params["admin_url"].present?
      redirect_to params["admin_url"]
    else
      render "lti_launches/index", layout: "client"
    end
  end

  protected

  def verify_oauth_response
    # Check for OAuth errors
    if request.env["omniauth.auth"].blank?
      error_type = env["omniauth.error.type"]
      if request.env["omniauth.strategy"].present? && request.env["omniauth.strategy"].name.present?
        error = "There was a problem communicating with #{request.env['omniauth.strategy'].name.titleize}. Error: #{error_type}"
      else
        error = "There was a problem communicating with the remote service. Error: #{error_type}"
      end

      if request.env["omniauth.strategy"].name == "canvas"
        flash[:error] = error
      else
        flash[:error] = "#{error} If this problem persists try signing up with a different service or create an #{Rails.application.secrets.application_name} account with just an email and password.".html_safe
      end

      if request.env["omniauth.origin"].present?
        redirect_to request.env["omniauth.origin"]
      else
        redirect_to new_user_registration_url
      end

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
    if authentication
      if !authentication.errors[:provider].empty?
        user_link = "user"
        message = "Another #{Rails.application.secrets.application_name} account: #{user_link} has already been associated with the specified #{auth['provider']} account."
      else
        message = authentication.errors.full_messages.join('<br />')
      end
    else
      message = ex.to_s
    end
    flash[:error] = "Your #{Rails.application.secrets.application_name} account could not be associated with this account: #{message}".html_safe
    redirect_to after_sign_in_path_for(current_user)
  end

  def find_using_oauth
    return if @user # Previous filter was successful and we already have a user
    if @user = User.find_for_oauth(request.env["omniauth.auth"])
      @user.update_oauth(request.env["omniauth.auth"])
      @user.skip_confirmation!
      @user.save # do we want to log an error if save fails?
      sign_in_or_register(params[:action].titleize)
    end
  end

  def create_using_oauth
    return if @user # Previous filter was successful and we already have a user
    auth = request.env["omniauth.auth"]
    kind = params[:action].titleize # Should give us Facebook, Twitter, Linked In, etc
    @user = User.new
    @user.apply_oauth(auth)
    @user.skip_confirmation!
    @user.save!
    sign_in_or_register(kind)
  rescue ActiveRecord::RecordInvalid => ex
    # A user is already registered with the same email and he tried to sign in using facebook but the
    # account is not connected to facebook.
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
