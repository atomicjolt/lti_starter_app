class OauthStateMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.params["state"]
      if oauth_state = OauthState.find_by(state: request.params["state"])
        env["oauth.state"] = JSON.parse(oauth_state.payload) || {}
        lti_application_instance = LtiApplicationInstance.find_by(lti_key: env["oauth.state"]["oauth_consumer_key"])
        env["canvas.url"] = lti_application_instance.lti_consumer_uri
        oauth_state.destroy
      end
    end
    @app.call(env)
  end
end