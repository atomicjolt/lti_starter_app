class OauthStateMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.params["state"] && request.params["code"]
      if oauth_state = OauthState.find_by(state: request.params["state"])
        env["oauth.state"] = JSON.parse(oauth_state.payload) || {}
        application_instance = ApplicationInstance.find_by(lti_key: env["oauth.state"]["oauth_consumer_key"])
        env["canvas.url"] = application_instance.lti_consumer_uri
        oauth_state.destroy
      else
        raise OauthStateMiddlewareException, "Invalid state in OAuth callback"
      end
    end
    @app.call(env)
  end
end

class OauthStateMiddlewareException < RuntimeError
end