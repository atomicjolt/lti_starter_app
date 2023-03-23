class Api::LtiDeepLinkJwtController < Api::ApiApplicationController
  # ###########################################################
  # Used to sign a response to the platform
  def create
    token = decoded_jwt_token(request)

    content_items = {
      "type" => "html",
      "html" => "<h1>Atomic Jolt</h1>",
    }

    jwt = AtomicLti::DeepLinking.create_deep_link_jwt(
      iss: token["iss"],
      deployment_id: token[AtomicLti::Definitions::DEPLOYMENT_ID],
      content_items: content_items,
      deep_link_claim_data: token["data"],
    )

    render json: {
      jwt: jwt,
    }
  end

end
