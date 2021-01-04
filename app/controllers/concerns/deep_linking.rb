module Concerns
  module DeepLinking
    extend ActiveSupport::Concern

    # ###########################################################
    # Create a jwt to sign a response to the platform
    def create_deep_link_jwt(
      application_instance:,
      token:,
      params:,
      jwt_context_id:,
      jwt_tool_consumer_instance_guid:,
      host:
    )
      platform_iss = token["iss"]
      lti_deployment = LtiDeployment.find_by(deployment_id: token["deployment_id"])
      client_id = lti_deployment.lti_install.client_id

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
        LtiAdvantage::Definitions::CONTENT_ITEM_CLAIM => content_items(
          params: params,
          jwt_context_id: jwt_context_id,
          jwt_tool_consumer_instance_guid: jwt_tool_consumer_instance_guid,
          host: host,
          application_instance: application_instance,
        ),
      }

      if token["data"].present?
        payload[LtiAdvantage::Definitions::DEEP_LINKING_DATA_CLAIM] = token["data"]
      end

      LtiAdvantage::Authorization.sign_tool_jwt(application_instance, payload)
    end

    private

    def content_items(
      params:,
      jwt_context_id:,
      jwt_tool_consumer_instance_guid:,
      host:,
      application_instance:
    )
      out = []

      if params[:type] == "html"
        out << {
          "type" => "html",
          "html" => "<h1>#{params[:title] || 'Atomic Jolt'}</h1>",
        }
      elsif params[:type] == "ltiResourceLink"
        lti_launch = LtiLaunch.create!(
          tool_consumer_instance_guid: jwt_tool_consumer_instance_guid,
          context_id: jwt_context_id,
          application_instance_id: application_instance.id,
          config: { title: params[:title] },
        )
        url = Rails.application.routes.url_helpers.lti_launch_url(
          lti_launch,
          protocol: "https",
          host: host,
        )
        out << {
          "type" => "ltiResourceLink",
          "title" => "Atomic Jolt",
          "url" => url,
        }
      end

      out
    end
  end
end
