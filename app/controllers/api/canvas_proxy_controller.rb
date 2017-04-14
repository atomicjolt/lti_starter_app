class Api::CanvasProxyController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  before_action :protect_canvas_api

  def proxy
    result = canvas_api.proxy(canvas_proxy_params[:type], canvas_proxy_params, request.body.read)
    response.status = result.code

    allowed_headers = %w{
      content-type link p3p x-canvas-meta x-canvas-user-id
      x-rate-limit-remaining x-request-context-id x-request-cost
      x-request-processor x-robots-tag x-runtime x-session-id
      x-ua-compatible x-xss-protection
    }

    result.headers.each do |name, val|
      response.headers[name] = val if allowed_headers.include?(name)
    end

    render plain: result.body
  end

  def canvas_proxy_params
    params.permit(:account_id, :lti_key, :type, :id, :format, :controller, :action)
  end

end
