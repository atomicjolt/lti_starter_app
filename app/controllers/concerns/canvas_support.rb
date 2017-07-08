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
          client_id: current_application_instance.site.oauth_key,
          client_secret: current_application_instance.site.oauth_secret,
          redirect_uri: user_canvas_omniauth_callback_url(
            subdomain: Rails.application.secrets.oauth_subdomain,
            protocol: "https",
          ),
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

    def protect_canvas_api(type: params[:lms_proxy_call_type], context_id: params[:context_id])
      return if canvas_api_authorized(type: type, context_id: context_id)
      user_not_authorized
    end

    def canvas_api_authorized(type: params[:lms_proxy_call_type], context_id: params[:context_id])
      canvas_api_permissions.has_key?(type) &&
        allowed_roles(type: type).present? &&
        (allowed_roles(type: type) & current_user.nil_or_context_roles(context_id).map(&:name)).present?
    end

    def allowed_roles(type: params[:lms_proxy_call_type])
      roles = (canvas_api_permissions[type] || []) + (canvas_api_permissions[:common] || [])
      roles = canvas_api_permissions[:default] || [] if roles.empty?
      roles
    end

    def canvas_api_permissions
      @canvas_api_permissions ||= current_application_instance.application.canvas_api_permissions
    end

    class CanvasApiTokenRequired < LMS::Canvas::CanvasException
    end

  end
end
