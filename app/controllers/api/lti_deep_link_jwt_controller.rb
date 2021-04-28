class Api::LtiDeepLinkJwtController < Api::ApiApplicationController
  include DeepLinking

  # ###########################################################
  # Used to sign a response to the platform
  def create
    jwt = create_deep_link_jwt(
      application_instance: current_application_instance,
      token: decoded_jwt_token(request),
      params: params,
      jwt_context_id: jwt_context_id,
      jwt_tool_consumer_instance_guid: jwt_tool_consumer_instance_guid,
      host: request.host,
    )
    render json: {
      jwt: jwt,
    }
  end
end
