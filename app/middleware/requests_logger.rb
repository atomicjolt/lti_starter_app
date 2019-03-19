class RequestsLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)

    request = Rack::Request.new(env)

    tenant = Lti::Request.oauth_consumer_key(request)
    warden_session = request.session["warden.user.user.key"]
    user_id = warden_session[0][0] if warden_session
    lti_launch = request.path == "/lti_launches"
    error = /^5/ === @status.to_s
    request_id = ActionDispatch::Request.new(env).request_id
    host = request.host_with_port

    ::RequestLog.create(
      request_id: request_id,
      tenant: tenant,
      user_id: user_id,
      lti_launch: lti_launch,
      error: error,
      host: host,
    )

    [@status, @headers, @response]
  end
end
