module Concerns
  module CanvasSupport
    extend ActiveSupport::Concern

    protected

    def canvas_api
      if current_application_instance.canvas_token.present?
        LMS::Canvas.new(
          UrlHelper.scheme_host_port(current_application_instance.site.url),
          current_application_instance.canvas_token,
        )
      elsif auth = canvas_auth(current_application_instance)
        options = {
          client_id: Rails.application.secrets.canvas_developer_id,
          client_secret: Rails.application.secrets.canvas_developer_key,
          redirect_uri: "https://#{request.host}/auth/canvas/callback",
          refresh_token: auth.refresh_token,
        }
        LMS::Canvas.new(
          UrlHelper.scheme_host_port(current_application_instance.site.url),
          auth,
          options,
        )
      else
        raise CanvasApiTokenRequired, "Could not find a global or user canvas api token."
      end
    end

    def canvas_auth(current_application_instance)
      current_user.authentications.find_by(
        provider_url: UrlHelper.scheme_host_port(current_application_instance.site.url),
      )
    end

    def protect_canvas_api
      canvas_api_permissions = current_application_instance.
        application.canvas_api_permissions.
        split(",")
      user_not_authorized unless canvas_api_permissions.include?(params[:type])
    end

    class CanvasApiTokenRequired < LMS::Canvas::CanvasException
    end

  end
end
