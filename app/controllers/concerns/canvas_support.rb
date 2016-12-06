module Concerns
  module CanvasSupport
    extend ActiveSupport::Concern

    protected

      def canvas_api
        if current_lti_application_instance.canvas_token.present?
          LMS::API.new(UrlHelper.scheme_host(current_lti_application_instance.lti_consumer_uri), current_lti_application_instance.canvas_token)
        elsif auth = canvas_auth(current_lti_application_instance)
          options = {
            client_id: Rails.application.secrets.canvas_developer_id,
            client_secret: Rails.application.secrets.canvas_developer_key,
            redirect_uri: "https://#{request.host}/auth/canvas/callback",
            refresh_token: auth.refresh_token
          }
          LMS::API.new(UrlHelper.scheme_host(current_lti_application_instance.lti_consumer_uri), auth, options)
        else
          nil
        end
      end

      def canvas_auth(current_lti_application_instance)
        current_user.authentications.find_by(provider_url: current_lti_application_instance.lti_consumer_uri)
      end

      def protect_canvas_api
        canvas_api_permissions = current_lti_application_instance.lti_application.canvas_api_permissions.split(",")
        user_not_authorized unless canvas_api_permissions.include?(params[:type])
      end
  end
end
