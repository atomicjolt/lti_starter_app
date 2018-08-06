class Api::ImsImportsController < ApplicationController
  include Concerns::CanvasImsccSupport

  def create
    data = params[:data]
    if data.present?
      lti_launches = if data[:lti_launches].present?
                       lti_launches_params(data)[:lti_launches]
                     end

      data = {
        lti_launches: lti_launches,
        context_id: params[:context_id],
        tool_consumer_instance_guid: params[:tool_consumer_instance_guid],
      }

      ImsImportJob.perform_later(data.to_json)
    end

    render json: { status: "completed" }
  end

  private

  def lti_launches_params(current_params)
    current_params.permit(
      lti_launches: [
        :token,
        config: {},
      ],
    )
  end

end
