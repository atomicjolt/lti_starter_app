OmniAuth.config.before_request_phase do |env|
  request = Rack::Request.new(env)
  state = "#{SecureRandom.hex(24)}#{DateTime.now.to_i}"

  # Inject app_callback_url here so we don't trust the client value
  payload = request.params.to_h

  if payload["authorization"].present? && token = AuthToken.decode(payload["authorization"])
    payload["app_callback_url"] = token[0]["app_callback_url"]
  else
    payload["app_callback_url"] = Rails.application.routes.url_helpers.user_canvas_omniauth_callback_url(
      host: Integrations::CanvasApiSupport.oauth_host,
      protocol: "https",
    )
  end

  OauthState.create!(state: state, payload: payload.to_json)
  env["omniauth.strategy"].options[:authorize_params].state = state

  # By default omniauth will store all params in the session. The code above
  # stores the values in the database so we remove the values from the session
  # since the amount of data in the original params object will overflow the
  # allowed cookie size
  env["rack.session"].delete("omniauth.params")
end

OmniAuth.config.mock_auth[:canvas] = OmniAuth::AuthHash.new(
  {
    provider: "canvas",
    uid: "12345",
    info: {
      url: "http://example.instructure.com",
    },
  },
)
