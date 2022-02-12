class MfaController < ApplicationController
  before_action :authenticate_user!

  def index
    # Generate a new otp secret if it isn't enabled
    if !current_user.otp_required_for_login
      current_user.otp_secret = User.generate_otp_secret
      @codes = current_user.generate_otp_backup_codes!
      current_user.save!

      issuer = "Atomic Jolt"
      label = "#{Rails.application.secrets.application_name} - #{current_user.email}"

      @otp_uri = current_user.otp_provisioning_uri(label, issuer: issuer)

      qrcode = RQRCode::QRCode.new(@otp_uri)

      # NOTE: showing with default options specified explicitly
      @qrcode_svg = qrcode.as_svg(
        color: "000",
        shape_rendering: "crispEdges",
        module_size: 5,
        standalone: true,
        use_path: true
      )
    end
  end

  def update
    current_user.otp_required_for_login = !params[:mfa_enabled].to_i.zero?

    current_user.save!
    redirect_to :edit_user_registration
  end
end
