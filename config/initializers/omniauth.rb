OmniAuth.config.before_request_phase do |env|
  request = Rack::Request.new(env)
  state = "#{SecureRandom.hex(24)}#{DateTime.now.to_i}"

  raise OmniAuth::AuthenticityError, "No authorization" if request.params["oauth_authorization"].blank?

  # CSRF protection
  token = OauthJwt.decode_token(request.params["oauth_authorization"])
  raise OmniAuth::AuthenticityError if token[0]["app_callback_url"].blank?

  payload = token[0]
  OauthState.create!(state: state, payload: payload.to_json)
  env["omniauth.strategy"].options[:authorize_params].state = state

  # By default omniauth will store all params in the session. The code above
  # stores the values in the database so we don't rely on cookies.
  env["rack.session"].delete("omniauth.params")
end

# We cannot use the built-in CSRF protection since there won't be a session
# cookie in an LTI launch. We mitigate CSRF as follows:
# - rely on a signed JWT in the above request
# - force the auth request to be a POST (Omniauth 2.0 default)
# - during an LTI launch verify that the oauth uid matches the user in the jwt

OmniAuth.config.request_validation_phase = nil

OmniAuth.config.mock_auth[:canvas] = OmniAuth::AuthHash.new(
  {
    provider: "canvas",
    uid: "12345",
    info: {
      url: "http://example.instructure.com",
    },
  },
)
