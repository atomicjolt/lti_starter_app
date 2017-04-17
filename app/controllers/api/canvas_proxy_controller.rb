class Api::CanvasProxyController < Api::ApiApplicationController

  include Concerns::CanvasSupport

  before_action :protect_canvas_api

  def proxy
    result = canvas_api.proxy(params[:type], params.to_unsafe_h, request.body.read)
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

    render json: result.body
  end

end
