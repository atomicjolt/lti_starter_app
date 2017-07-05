require "jwt"

module AuthToken

  # More information on jwt available at
  # http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#rfc.section.4.1.6
  def self.issue_token(payload, exp = 24.hours.from_now, secret = nil, aud = nil)
    payload["iat"] = DateTime.now.to_i    # issued at claim
    payload["exp"] = exp.to_i             # Default expiration set to 24 hours.
    payload["aud"] = aud || Rails.application.secrets.auth0_client_id
    JWT.encode(
      payload,
      secret || Rails.application.secrets.auth0_client_secret,
      "HS512",
    )
  end

  def self.valid?(token, secret = nil)
    JWT.decode(token, secret || Rails.application.secrets.auth0_client_secret)
  end
end
