module LtiAdvantage
  class Authorization
    def self.application_instance_from_token(token)
      byebug
      return unless token

      decoded_token = JWT.decode(token, nil, false)
      payload = decoded_token[PAYLOAD]
      client_id = payload["aud"]
      iss = payload["iss"]
      deployment_id = payload[LtiAdvantage::Definitions::DEPLOYMENT_ID]
      if client_id && deployment_id && iss
        ApplicationInstance.by_client_and_deployment(client_id, deployment_id, iss)
      end
    end

    # Validates a token provided by an LTI consumer
    def self.validate_token(application_instance, token)
      # Get the iss value from the original request during the oidc call.
      # Use that value to figure out which jwk we should use.
      decoded_token = JWT.decode(token, nil, false)
      iss = decoded_token.dig(0, "iss")
      cache_key = "#{iss}_jwks"

      jwk_loader = ->(options) do
        jwks = Rails.cache.read(cache_key)
        if options[:invalidate] || jwks.blank?
          deployment_id = decoded_token.dig(0, LtiAdvantage::Definitions::DEPLOYMENT_ID)
          lti_deployment = LtiDeployment.find_by(
            deployment_id: deployment_id,
          )
          if lti_deployment.blank?
            raise LtiAdvantage::Exceptions::NoLTIDeployment, "No LTI Deployment found with #{deployment_id}"
          end

          client_id = lti_deployment.lti_install.client_id
          jwks = JSON.parse(
            HTTParty.get(application_instance.application.jwks_url(iss, client_id)).body,
          ).deep_symbolize_keys
          Rails.cache.write(cache_key, jwks, expires_in: 12.hours)
        end
        jwks
      end

      lti_token, _keys = JWT.decode(token, nil, true, { algorithms: ["RS256"], jwks: jwk_loader })
      lti_token
    end

    def self.sign_tool_jwt(application_instance, payload)
      jwk = application_instance.application.current_jwk
      JWT.encode(payload, jwk.private_key, jwk.alg, kid: jwk.kid, typ: "JWT")
    end

    def self.client_assertion(application_instance, lti_token)
      # https://www.imsglobal.org/spec/lti/v1p3/#token-endpoint-claim-and-services
      # When requesting an access token, the client assertion JWT iss and sub must both be the
      # OAuth 2 client_id of the tool as issued by the learning platform during registration.
      # Additional information:
      # https://www.imsglobal.org/spec/security/v1p0/#using-json-web-tokens-with-oauth-2-0-client-credentials-grant

      lti_deployment = LtiDeployment.find_by(deployment_id: lti_token[LtiAdvantage::Definitions::DEPLOYMENT_ID])
      lti_install = lti_deployment.lti_install

      payload = {
        iss: application_instance.lti_key, # A unique identifier for the entity that issued the JWT
        sub: lti_install.client_id, # "client_id" of the OAuth Client
        aud: application_instance.token_url(lti_token["iss"], lti_install.client_id), # Authorization server identifier
        iat: Time.now.to_i, # Timestamp for when the JWT was created
        exp: Time.now.to_i + 300, # Timestamp for when the JWT should be treated as having expired
        # (after allowing a margin for clock skew)
        jti: SecureRandom.hex(10), # A unique (potentially reusable) identifier for the token
      }
      sign_tool_jwt(application_instance, payload)
    end

    def self.request_token(application_instance, lti_token)
      lti_user_id = lti_token["sub"]
      cache_key = "#{lti_user_id}_authorization"

      authorization = Rails.cache.read(cache_key)
      return authorization if authorization.present?

      # Details here:
      # https://www.imsglobal.org/spec/security/v1p0/#using-json-web-tokens-with-oauth-2-0-client-credentials-grant
      body = {
        grant_type: "client_credentials",
        client_assertion_type: "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
        scope: LtiAdvantage::Definitions.scopes.join(" "),
        client_assertion: client_assertion(application_instance, lti_token),
      }
      headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
      }

      lti_deployment = LtiDeployment.find_by(
        deployment_id: lti_token[LtiAdvantage::Definitions::DEPLOYMENT_ID],
      )
      client_id = lti_deployment.lti_install.client_id
      result = HTTParty.post(application_instance.token_url(lti_token["iss"], client_id), body: body, headers: headers)
      authorization = JSON.parse(result.body)

      Rails.cache.write(cache_key, authorization, expires_in: authorization["expires_in"].to_i)

      authorization
    end
  end
end
