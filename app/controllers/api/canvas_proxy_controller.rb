class Api::CanvasProxyController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  before_action :protect_canvas_api

  def proxy
    api = if params[:bundle_instance_token].present?
            canvas_api(application_instance: targeted_app_instance)
          else
            canvas_api(application_instance: current_application_instance)
          end
    result = api.proxy(params[:lms_proxy_call_type], params.to_unsafe_h, request.body.read, params[:get_all])
    allowed_headers = %w{
      content-type link p3p x-canvas-meta x-canvas-user-id
      x-rate-limit-remaining x-request-context-id x-request-cost
      x-request-processor x-robots-tag x-runtime x-session-id
      x-ua-compatible x-xss-protection
    }

    if result.class == Array
      response.status = 200
      render json: result
    else
      response.status = result.code
      result.headers.each do |name, val|
        response.headers[name] = val if allowed_headers.include?(name)
      end
      render json: result.body
    end
  rescue LMS::Canvas::CanvasException => e
    render json: { error: e, status: e.status }, status: e.status
  end
end
