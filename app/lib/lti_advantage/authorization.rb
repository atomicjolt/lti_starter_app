module LtiAdvantage
  class Authorization
    def self.client_assertion(application_instance, lti_token)
      payload = {
        iss: application_instance.lti_key, # A unique identifier for the entity that issued the JWT
        sub: application_instance.application.client_id, # "client_id" of the OAuth Client
        aud: oauth2_url(lti_token), # Authorization server identifier
        iat: Time.now.to_i, # Timestamp for when the JWT was created
        exp: Time.now.to_i + 300, # Timestamp for when the JWT should be treated as having expired (after allowing a margin for clock skew)
        jti: SecureRandom.hex(10), # A unique (potentially reusable) identifier for the token
      }

      jwk = application_instance.current_jwk
      JWT.encode(payload, jwk.private_key, jwk.alg, kid: jwk.kid, typ: "JWT")
    end

    def self.oauth2_url(lti_token)
      "#{lti_token["iss"]}/login/oauth2/token"
    end

    def self.get_authorization(application_instance, lti_token)
      body = {
        grant_type: "client_credentials",
        client_assertion_type: "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
        scope: LtiAdvantage::Definitions::scopes,
        client_assertion: client_assertion(application_instance, lti_token)
      }

      result = HTTParty.post(oauth2_url(lti_token), body: body)
      byebug
      JSON.parse(result.body)

    end
  end
end
