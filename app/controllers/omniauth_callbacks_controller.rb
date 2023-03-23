class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :sign_out_user, except: [:passthru]
  before_action :verify_oauth_response, except: [:passthru]
  before_action :fix_provider_url, except: [:passthru]
  before_action :login_previous_user, except: [:passthru]
  before_action :find_using_oauth, except: [:passthru]
  before_action :create_using_oauth, except: [:passthru]

  layout "omniauth"

  def passthru
    render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
  end

  def canvas
    if !@user
      raise ActionController::RoutingError.new('Not Found')
    end

    site = Site.find(request.env.dig("oauth_state", "site_id"))
    canvas_url = UrlHelper.scheme_host_port(site.url)

    if @user.lti_provider.blank?
      auth = @user.authentications.find_by(provider_url: canvas_url, provider: "canvas")
      @user.lti_provider = UrlHelper.host(auth["provider_url"])
      @user.lms_user_id = auth.uid
    end

    @user.save!
    @canvas_auth_required = false

    if oauth_complete_url.present?
      redirect_to oauth_complete_url, allow_other_host: true
    else
      render "omniauth/complete"
    end
  end

  protected

  # Ensure that the user isn't already logged in via a session cookie. For our apps we
  # want the oauth return data to determine the user.
  def sign_out_user
    sign_out :user
  end

  def oauth_complete_url
    request.env.dig("oauth_state", "oauth_complete_url")
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

    params = oauth_state && JSON.parse(oauth_state.payload)
    application_instance = if params&.dig("application_instance_id")
                             ApplicationInstance.find(params["application_instance_id"])
                           end

    flash.discard
    err = oauth_error

    if oauth_complete_url
      flash[:error] = format_oauth_error_message
      render "omniauth/error", status: :forbidden
    # The Global Atomic Jolt Installer key/secret is disabled
    elsif err[:error_type] == :unauthorized_client
      flash[:error] = "Authorization denied.  Please ensure that the Atomic Jolt Application Installer key is enabled. (#{application_instance&.site&.oauth_key})"
      render "omniauth/error", status: :forbidden
    # User clicked Cancel during the OAuth process
    elsif err[:error_type] == :access_denied
      # This displays an error to the user but for each app it should probably take the user
      # back to their starting page
      flash[:error] = "Authorization not granted. Please refresh the page to try again."
      render "omniauth/error", status: :forbidden
    # User does not have install LTI tool permissions
    elsif err[:error_type] == :missing_permissions || err[:error_type] == :invalid_scope
      flash[:error] = format_oauth_error_message
      render "omniauth/error", status: :forbidden
    # Other errors
    else
      flash[:error] = format_oauth_error_message
      render "omniauth/error", status: :forbidden
    end
  end

  def fix_provider_url
    # Ensure that the provider URL is what we're expecting. The urls might not agree if the user
    # is using a different vanity domain than we have configured in the site.
    site = Site.find(request.env.dig("oauth_state", "site_id"))

    if request.env["omniauth.auth"]["info"]["url"] != site.url
      request.env["omniauth.auth"]["info"]["url"] = site.url
    end
  end


  def oauth_error
    # Keep these and use them for debugging omniauth.
    # exception = request.env['omniauth.error']
    # error_type = request.env['omniauth.error.type']
    # strategy = request.env['omniauth.error.strategy']
    # exception.error_reason
    {
      error_type: request.env["omniauth.error.type"],
      error: request.env["omniauth.error"].to_s,
      strategy: request.env["omniauth.strategy"]&.name&.titleize,
    }
  end

  def format_oauth_error_message
    %{
      There was a problem communicating with #{request.env['omniauth.strategy']&.name&.titleize}.
      Error: #{request.env['omniauth.error.type']}
    }
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

  # This will ensure that a user previously logged in via LTI will
  # still be logged in after the OAuth Dance with Canvas
  def login_previous_user
    auth = request.env["omniauth.auth"]
    user_id = request.env.dig("oauth_state", "user_id")
    if auth && user_id.present?
      @user = User.find(user_id)
      # Validate it's the same user
      lms_user_id = auth["uid"].to_s
      match = lms_user_id.present? && @user.lms_user_id == lms_user_id
      if !match
        flash[:error] =
          "The Canvas user does not match who we expected. Please ensure you're logging in with the correct account."
        render "omniauth/error", status: :forbidden
        return
      end

      sign_in_or_register(auth["provider"].titleize)
      @user.update_oauth(request.env["omniauth.auth"])
      @user.save!
    end
  end


  # Find a previous account by this oauth
  def find_using_oauth
    return if @user # Previous filter was successful and we already have a user

    if @user = User.for_auth(request.env["omniauth.auth"])
      @user.skip_confirmation!
      kind = params[:action].titleize
      @user.update_oauth(request.env["omniauth.auth"])
      @user.save # do we want to log an error if save fails?
      sign_in_or_register(kind)
    end
  end

  # Make a new account based on this oauth
  def create_using_oauth
    return if @user # Previous filter was successful and we already have a user

    auth = request.env["omniauth.auth"]
    kind = params[:action].titleize # Should give us Facebook, Twitter, Linked In, etc
    @user = User.new
    @user.skip_confirmation!
    @user.password = Devise.friendly_token(72)
    @user.password_confirmation = @user.password
    @user.create_method = User.create_methods[:oauth]
    @user.apply_oauth(auth)
    @user.save!
    sign_in_or_register(kind)
  end

  def sign_in_or_register(kind)
    if kind == "Canvas"
      @user.add_to_role("canvas_oauth_user")
    end
    sign_in(@user, event: :authentication)

    if should_redirect?
      redirect_to after_sign_in_path_for(@user), allow_other_host: true
    end
  end

  def should_redirect?
    return false if ["canvas"].include?(params[:action]) # Don't redirect we need to do more configuration
    true
  end
end
