module Integrations

  class CanvasApiSupport

    def initialize(user, canvas_course, application_instance)
      @user = user
      @canvas_course = canvas_course
      @application_instance = application_instance
    end

    def api
      api = find_canvas_api(@application_instance, @user, @canvas_course)
      if api.blank?
        raise CanvasApiTokenRequired, "Could not find a global or user canvas api token."
      end
      api
    end

    def find_canvas_api(application_instance, user, canvas_course)
      application_instance.oauth_precedence.each do |kind|
        if api = api_for(kind, application_instance, user, canvas_course)
          return api # Return the first authentication object we find
        end
      end
      nil # Unable to find Canvas API token
    end

    def api_for(kind, application_instance, user, canvas_course)
      url = UrlHelper.scheme_host_port(application_instance.site.url)
      site = application_instance.site

      case kind
      when "global"
        global_api(application_instance, url)
      when "user"
        user_api(user, url, site)
      when "application_instance"
        application_instance_api(application_instance, url, site)
      when "course"
        course_api(canvas_course, url, site)
      end
    end

    # Global token set on the application instance first.
    # This means someone set a token on the app and they
    # do not wish for any users to have to authenticate
    def global_api(application_instance, url)
      if application_instance.canvas_token.present?
        LMS::Canvas.new(
          url,
          application_instance.canvas_token,
        )
      end
    end

    # Look for an auth object associated with the application instance
    # If a user with admin permissions onboards their token can be associated
    # with the application instance
    # TODO This needs to use an account id so that we can take the current
    # account and figure out the correct token for that account
    # TODO When associating a token with an application instance
    # be sure to check that the token has complete access to the account
    def application_instance_api(application_instance, url, site)
      return nil unless application_instance.present?
      if auth = application_instance.authentications.find_by(provider_url: url)
        CanvasApiSupport.refreshable_auth(auth, url, site)
      end
    end

    # Look for an auth object associated with the course. This
    # will have been obtained during the onboarding process
    def course_api(course, url, site)
      return nil unless course.present?
      if auth = course.authentications.find_by(provider_url: url)
        CanvasApiSupport.refreshable_auth(auth, url, site)
      end
    end

    # User specific authentication.
    def user_api(user, url, site)
      return nil unless user.present?
      if auth = user.authentications.find_by(provider_url: url)
        CanvasApiSupport.refreshable_auth(auth, url, site)
      end
    end

    def self.refreshable_auth(auth, url, site)
      options = {
        client_id: site.oauth_key,
        client_secret: site.oauth_secret,
        redirect_uri: Rails.application.routes.url_helpers.user_canvas_omniauth_callback_url(
          host: CanvasApiSupport.oauth_host,
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

    def self.oauth_host
      "#{Application::AUTH}.#{Rails.application.secrets.application_root_domain}"
    end

    class CanvasApiTokenRequired < LMS::Canvas::CanvasException
    end
  end

end
