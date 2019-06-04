module Concerns
  module OpenIdConnectSupport
    extend ActiveSupport::Concern

    protected
    def build_response(state, params, nonce)
      iss = params["iss"]
      uri = URI.parse(oidc_for(iss))
      uri_params = Rack::Utils.parse_query(uri.query)
      auth_params = {
        response_type: "id_token",
        redirect_uri: params[:target_link_uri],
        response_mode: "form_post",
        client_id: client_id(iss),
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

    # This identifies the application i.e. Atomic Assessments and is setup in
    # the developer keys: https://atomicjolt.beta.instructure.com/accounts/1/developer_keys
    def client_id(iss)
      return Rails.application.secrets.canvas_lti_tool_id if iss.include?("instructure.com")
      return "1" if iss.include?("imsglobal.org")
    end

    def oidc_for(iss)
      return "https://canvas.instructure.com/api/lti/authorize_redirect" if iss.include?("instructure.com")
      return "https://canvas.instructure.com/api/lti/authorize_redirect" if iss.include?("sakaicloud.com")
      return "https://lti-ri.imsglobal.org/platforms/159/authorizations/new" if iss.include?("imsglobal.org")
    end

  end
end
