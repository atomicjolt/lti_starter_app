# NOTE if you include the 
module Concerns
  module CanvasSupport
    extend ActiveSupport::Concern
    include OauthHelper
    include Concerns::JwtToken

    protected

    def canvas_api(
      application_instance: current_application_instance,
      user: current_user,
      canvas_course: current_canvas_course
    )
      url = UrlHelper.scheme_host_port(application_instance.site.url)
      if application_instance.canvas_token.present?
        global_auth(url, application_instance.canvas_token)
      elsif auth = canvas_auth_instance(application_instance.site, application_instance: application_instance)
        user_auth(auth, url, application_instance.site)
      elsif auth = canvas_auth_course(application_instance.site, canvas_course: canvas_course)
        user_auth(auth, url, application_instance.site)
      elsif auth = canvas_auth(application_instance.site, user: user)
        user_auth(auth, url, application_instance.site)
      else
        raise CanvasApiTokenRequired, "Could not find a global or user canvas api token."
      end
    end

    def global_auth(url, canvas_token)
      LMS::Canvas.new(
        url,
        canvas_token,
      )
    end

    def user_auth(auth, url, site)
      options = {
        client_id: site.oauth_key,
        client_secret: site.oauth_secret,
        redirect_uri: Rails.application.routes.url_helpers.user_canvas_omniauth_callback_url(
          host: oauth_host,
          protocol: "https",
        ),
        refresh_token: auth.refresh_token,
      }
      LMS::Canvas.new(
        url,
        auth,
        options,
      )
    end

    def canvas_auth_instance(site, application_instance:)
      return nil unless application_instance.present?
      application_instance.authentications.find_by(
        provider_url: UrlHelper.scheme_host_port(site.url),
      )
    end

    def canvas_auth_course(site, canvas_course: nil)
      return nil unless canvas_course.present?
      canvas_course.authentications.find_by(
        provider_url: UrlHelper.scheme_host_port(site.url),
      )
    end

    def canvas_auth(site, user: current_user)
      return nil unless user.present?
      user.authentications.find_by(
        provider_url: UrlHelper.scheme_host_port(site.url),
      )
    end

    def protect_canvas_api(type: params[:lms_proxy_call_type], context_id: jwt_context_id)
      return if canvas_api_authorized(type: type, context_id: context_id) && custom_api_checks_pass(type: type)
      user_not_authorized
    end

    def canvas_api_authorized(type: params[:lms_proxy_call_type], context_id: jwt_context_id)
      canvas_api_permissions.has_key?(type) &&
        allowed_roles(type: type).present? &&
        (allowed_roles(type: type) & current_user_roles(context_id: context_id)).present?
    end

    def allowed_roles(type: params[:lms_proxy_call_type])
      roles = (canvas_api_permissions[type] || []) + (canvas_api_permissions[:common] || [])
      roles = canvas_api_permissions[:default] || [] if roles.empty?
      roles
    end

    def canvas_api_permissions
      @canvas_api_permissions ||= current_application_instance.application.canvas_api_permissions
    end

    def custom_api_checks_pass(type: nil)
      # Add custom logic to protect specific api calls
    end

    class CanvasApiTokenRequired < LMS::Canvas::CanvasException
    end

  end
end
