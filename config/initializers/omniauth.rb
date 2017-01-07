OmniAuth.config.before_request_phase do |env|
  request = Rack::Request.new(env)
  state = "#{SecureRandom.hex(24)}#{DateTime.now.to_i}"
  OauthState.create!(state: state, payload: request.params.to_json)
  env["omniauth.strategy"].options[:authorize_params].state = state
end
