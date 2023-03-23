# This JWT authorizes the client to Oauth to canvas
module OauthJwt
  def self.issue_token(
    app_callback_url:,
    site:,
    application_instance: nil,
    user: nil,
    oauth_complete_url: nil,
    canvas_url: nil,
    expiration: nil
  )
    attrs = {
      user_id: user&.id,
      site_id: site.id,
      application_instance_id: application_instance&.id,
      app_callback_url: app_callback_url,
      oauth_complete_url: oauth_complete_url,
      canvas_url: canvas_url,
    }
    AuthToken.issue_token(attrs, expiration || 15.minutes.from_now, site.secret)
  end

  def self.decode_token(token)
    decoded = AuthToken.decode(token, nil, false)
    site_id = decoded.dig(0, "site_id")
    raise OauthJwtTokenException, "No site id" if site_id.blank?

    AuthToken.decode(token, Site.find(site_id).secret, true)
  end
end
