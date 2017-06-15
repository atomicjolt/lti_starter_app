class OauthStateMiddleware
  def initialize(app)
    @app = app
  end

  def query_string(request, nonce)
    query = "?code=#{request.params['code']}"
    query << "&state=#{request.params['state']}"
    query << "&nonce=#{nonce}"
    query
  end

  def signed_query_string(query_string, secret)
    "#{query_string}&signature=#{sign(query_string, secret)}"
  end

  # Generates a signature given data and a secret
  def sign(str, secret)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, str)
  end

  # Verifies the signature value in a request
  def verify!(request, secret)
    query = query_string(request, request.params["nonce"])
    unless request.params["signature"] == sign(query, secret)
      raise OauthStateMiddlewareException, "OAuth state signatures do not match"
    end
  end

  # Since we channel all OAuth request through a single domain we have to have a way
  # to send the user back to their original subdomain.
  def redirect_original(request, state_params, application_instance)
    response = Rack::Response.new
    return_url = state_params["app_callback_url"]
    query = query_string(request, DateTime.now.to_i)
    return_url << signed_query_string(query, application_instance.site.oauth_secret)
    puts "*************************************************************************************"
    puts "redirecting to #{return_url}"
    puts "*************************************************************************************"
    response.redirect return_url
    response.finish
  end

  # Adds all parameters back into the request
  def restore_state(request, state_params, application_instance, oauth_state, env)
    verify!(request, application_instance.site.oauth_secret)
    # Restore the param from before the OAuth dance
    state_params.each do |key, value|
      request.update_param(key, value)
    end
    puts "*************************************************************************************"
    puts "restored params #{oauth_state.payload}"
    puts "*************************************************************************************"
    oauth_state.destroy
    env["canvas.url"] = application_instance.site.url
  end

  # Retrieves all original app parameters (settings) from the database during
  # an OAuth callback
  def get_state(request)
    if request.params["state"].present? && request.params["code"].present?
      if oauth_state = OauthState.find_by(state: request.params["state"])
        [oauth_state, JSON.parse(oauth_state.payload) || {}]
      else
        raise OauthStateMiddlewareException, "Invalid state during OAuth callback"
      end
    end
  end

  def call(env)
    request = Rack::Request.new(env)
    oauth_state, state_params = get_state(request)
    if oauth_state.present?
      application_instance = ApplicationInstance.find_by(lti_key: state_params["oauth_consumer_key"])
      if request.params["signature"].present?
        restore_state(request, state_params, application_instance, oauth_state, env)
      else
        return redirect_original(request, state_params, application_instance)
      end
    end
    @app.call(env)
  end
end

class OauthStateMiddlewareException < RuntimeError
end
