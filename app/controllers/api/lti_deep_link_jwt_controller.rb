class Api::LtiDeepLinkJwtController < Api::ApiApplicationController

  # ###########################################################
  # Used to sign a response to the platform
  def create
    token = decoded_jwt_token(request)
    platform_iss = token["iss"]
    application_instance = current_application_instance
    client_id = application_instance.application.client_id(platform_iss)

    payload = {
      iss: client_id, # A unique identifier for the entity that issued the JWT
      aud: platform_iss, # Authorization server identifier
      iat: Time.now.to_i, # Timestamp for when the JWT was created
      exp: Time.now.to_i + 300, # Timestamp for when the JWT should be treated as having expired
      # (after allowing a margin for clock skew)
      azp: client_id,
      nonce: SecureRandom.hex(10),
      LtiAdvantage::Definitions::MESSAGE_TYPE => "LtiDeepLinkingResponse",
      LtiAdvantage::Definitions::LTI_VERSION => "1.3.0",
      LtiAdvantage::Definitions::DEPLOYMENT_ID => token["deployment_id"],
      LtiAdvantage::Definitions::CONTENT_ITEM_CLAIM => content_items,
    }

    if token["data"].present?
      payload[LtiAdvantage::Definitions::DEEP_LINKING_DATA_CLAIM] = token["data"]
    end

    jwt =  LtiAdvantage::Authorization.sign_tool_jwt(current_application_instance, payload)

    render json: {
      jwt: jwt,
    }
  end

  private

  def content_items
    out = []

    if params[:type] == "html"
      out << {
        "type" => "html",
        "html" => "<h1>Atomic Jolt</h1>",
      }
    end

    out
  end
end
