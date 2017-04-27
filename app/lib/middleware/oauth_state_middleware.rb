class OauthStateMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.params["state"] && request.params["code"]
      if oauth_state = OauthState.find_by(state: request.params["state"])
        # Restore the param from before the OAuth dance
        state_params = JSON.parse(oauth_state.payload) || {}
        state_params.each do |key, value|
          request.update_param(key, value)
        end
        application_instance = ApplicationInstance.find_by(lti_key: state_params["oauth_consumer_key"])
        env["canvas.url"] = application_instance.site.url
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
