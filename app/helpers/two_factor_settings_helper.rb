module TwoFactorSettingsHelper
  def qr_code_as_svg(uri)
    RQRCode::QRCode.new(uri).as_svg(
      offset: 0,
      use_path: true,
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 4,
      standalone: true
    ).html_safe
  end
end
