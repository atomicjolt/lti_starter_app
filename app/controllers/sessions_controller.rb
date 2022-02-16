class SessionsController < Devise::SessionsController
  # Require our abstraction for encoding/deconding JWT.
  require "auth_token"
  include AuthenticateWithOtpTwoFactor

  respond_to :json

  prepend_before_action :authenticate_with_otp_two_factor,
                        if: -> { action_name == "create" && otp_two_factor_enabled? }

  def create
    # This is the default behavior from devise - view the sessions controller source:
    # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?

    # Here we're deviating from the standard behavior by issuing our JWT
    # to any JS based client.
    token = AuthToken.issue_token({ user_id: resource.id })
    respond_with resource, location: after_sign_in_path_for(resource) do |format|
      format.json do
        render json: {
          userId: resource.id,
          email: resource.email,
          displayName: resource.name,
          jwt_token: token,
        }
      end
    end
  end

  def destroy
    if params[:destroy_authentications]
      current_user.authentications.where(provider: "canvas").destroy_all
    end
    super
  end
end
