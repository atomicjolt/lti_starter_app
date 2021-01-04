module Concerns
  module OpenIdConnectSupport
    extend ActiveSupport::Concern

    protected

    def build_response(
      state: state,
      params: params,
      nonce: nonce,
      redirect_uri: redirect_uri
    )
      # The request doesn't contain any information to help us find the right application instance
      # so we have to use predefined URLs
      uri = URI.parse(current_application.oidc_url(params["iss"], params[:client_id]))
      uri_params = Rack::Utils.parse_query(uri.query)
      auth_params = {
        response_type: "id_token",
        redirect_uri: redirect_uri,
        response_mode: "form_post",
        client_id: params[:client_id],
        scope: "openid",
        state: state,
        login_hint: params[:login_hint],
        prompt: "none",
        lti_message_hint: params[:lti_message_hint],
        nonce: nonce,
      }.merge(uri_params)
      uri.fragment = uri.query = nil
      [uri.to_s, "?", auth_params.to_query].join
    end
  end
end
