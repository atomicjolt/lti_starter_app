class OauthStateMiddleware
  def initialize(app)
    @app = app
  end

  def query_string(request, nonce)
    {
      code: request.params["code"],
      state: request.params["state"],
      nonce: nonce,
    }.to_query
  end

  def signed_query_string(query, secret)
    "#{query}&signature=#{sign(query, secret)}"
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
  def redirect_original(request, state_params, site)
    response = Rack::Response.new
    return_url = state_params["app_callback_url"]
    query = query_string(request, SecureRandom.hex(64))
    return_url << "?"
    return_url << signed_query_string(query, site.secret)
    response.redirect return_url
    response.finish
  end

  # Adds all parameters back into the request
  def restore_state(request, state_params, site, oauth_state, env)
    verify!(request, site.secret)
    # Restore the param from before the OAuth dance
    state_params.each do |key, value|
      request.update_param(key, value)
    end
    oauth_state.destroy
    env["canvas.url"] = site.url
    env["oauth_consumer_key"] = state_params["oauth_consumer_key"]
  end

  # Retrieves all original app parameters (settings) from the database during
  # an OAuth callback
  def get_state(request)
    # TODO figure out if we can validate the code right here else we have a security problem
    if request.params["state"].present? && request.params["code"].present?
      if oauth_state = OauthState.find_by(state: request.params["state"])
        [oauth_state, JSON.parse(oauth_state.payload) || {}]
      else
        raise OauthStateMiddlewareException, "Invalid state during OAuth callback"
      end
    end
  end

  # Finds a site by looking for the site_id in the params or by finding an application instance by it's LTI key
  def get_site(state_params)
    # site id will typically be provided by apps that know the site that contains the Canvas url they want to OAuth
    # with but they may or may not have an associated application instance.
    if state_params["site_id"].present?
      site = Site.find(state_params["site_id"])
    end
    # LTI apps will typically have the oauth_consumer_key available
    if site.blank?
      application_instance = ApplicationInstance.find_by(lti_key: state_params["oauth_consumer_key"])
      site = application_instance.site
    end
    site
  end

  def call(env)
    request = Rack::Request.new(env)
    oauth_state, state_params = get_state(request)
    if oauth_state.present?
      site = get_site(state_params)
      if request.params["signature"].present?
        restore_state(request, state_params, site, oauth_state, env)
      else
        return redirect_original(request, state_params, site)
      end
    end
    @app.call(env)
  end
end

class OauthStateMiddlewareException < RuntimeError
end
