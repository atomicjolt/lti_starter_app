module Concerns
  module OpenIdConnectSupport
    extend ActiveSupport::Concern

    protected
    def build_response(state, params, nonce)
      # TODO this is a problem. The request doesn't contain any
      # information to help us find the right application instance
      # so we don't have the correct lti_oidc_url. Not sure what the IMS guys intend here
      uri = URI.parse(current_application_instance.lti_oidc_url)
      uri_params = Rack::Utils.parse_query(uri.query)
      auth_params = {
        response_type: "id_token",
        redirect_uri: params[:target_link_uri],
        response_mode: "form_post",
        client_id: current_application_instance.client_id,
        scope: "openid",
        state: state,
        login_hint: params[:login_hint],
        prompt: "none",
        lti_message_hint: params[:lti_message_hint],
        nonce: nonce
      }.merge(uri_params)
      uri.fragment = uri.query = nil
      [uri.to_s, "?", auth_params.to_query].join
    end

  end
end
