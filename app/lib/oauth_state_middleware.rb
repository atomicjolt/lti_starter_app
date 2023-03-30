class OauthStateMiddleware

  STATE_LIFETIME = 3 * 3600  # 3 hours

  def initialize(app)
    @app = app
  end

  def self.query_string(params, nonce)
    {
      code: params["code"],
      state: params["state"],
      nonce: nonce,
    }.to_query
  end

  def signed_query_string(query, secret)
    "#{query}&oauth_redirect_signature=#{OauthStateMiddleware.sign(query, secret)}"
  end

  # Generates a signature given data and a secret
  def self.sign(str, secret)
    OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, str)
  end

  # Verifies the signature value in a request
  def verify!(request, secret)
    query = OauthStateMiddleware.query_string(request.params, request.params["nonce"])
    unless request.params["oauth_redirect_signature"] == OauthStateMiddleware.sign(query, secret)
      raise OauthStateMiddlewareException, "OAuth state signatures do not match"
    end
  end

  # Since we channel all OAuth request through a single domain we have to have a way
  # to send the user back to their original subdomain.
  def redirect_original(request, state_params, site)
    response = Rack::Response.new
    # Note that app_callback_url is added by OmniAuth.config.before_request_phase
    # any value provided by a client will be overwritten in that method so that we
    # don't use/trust values sent by the client
    return_url = state_params["app_callback_url"]
    query = OauthStateMiddleware.query_string(request.params, SecureRandom.hex(64))
    return_url << "?"
    return_url << signed_query_string(query, site.secret)
    response.redirect return_url
    response.finish
  end

  # Adds state back into the environment
  def restore_state(request, state_params, site, oauth_state, env)
    verify!(request, site.secret)
    # Clear all existing params and restore the params
    # from before the OAuth dance
    allowed_params = ["code", "nonce", "state"]
    request.params.map { |k, _v| request.delete_param(k) if allowed_params.exclude?(k) }
    if state_params["request_params"].present?
      state_params["request_params"].each do |key, value|
        request.update_param(key, value)
      end
    end
    if state_params["request_env"].present?
      env.merge!(state_params["request_env"])
    end
    oauth_state.destroy
    env["canvas.url"] = state_params["canvas_url"]
    env["oauth_state"] = state_params
    env["oauth_code"] = request.params["code"]
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

  def validate_state(oauth_state)
    return if oauth_state.created_at > Time.now - STATE_LIFETIME

    oauth_state.destroy
    raise OauthStateMiddlewareException, "OAuth state has expired"
  end

  # Finds a site by looking for the site_id in the params
  def get_site(state_params)
    Site.find(state_params["site_id"])
  end

  def call(env)
    request = Rack::Request.new(env)
    oauth_state, state_params = get_state(request)
    if oauth_state.present?
      validate_state(oauth_state)
      site = get_site(state_params)
      if request.params["oauth_redirect_signature"].present?
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
