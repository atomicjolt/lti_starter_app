module Concerns
  module CanvasSupport
    extend ActiveSupport::Concern
    include Concerns::JwtToken

    protected

    def canvas_api(
      application_instance: current_application_instance,
      user: current_user,
      canvas_course: current_canvas_course,
      prefer_user: false
    )
      Integrations::CanvasApiSupport.new(user, canvas_course, application_instance, prefer_user).api
    end

    def protect_canvas_api(type: params[:lms_proxy_call_type], context_id: jwt_context_id)
      return if canvas_api_authorized(type: type, context_id: context_id) && custom_api_checks_pass(type: type)
      message = "This application is not authorized to access the requested Canvas API endpoint: #{type}"
      respond_to do |format|
        format.html { render html: helpers.tag.strong(message), status: :unauthorized }
        format.json { render json: { message: message }, status: :unauthorized }
      end
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
      true
    end
  end
end
