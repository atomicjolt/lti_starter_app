class Api::ImsImportsController < ApplicationController
  include Concerns::CanvasImsccSupport

  def create
    data = params[:data]
    if data.present?
      lti_launches = if data[:lti_launches].present?
                       lti_launches_params(data)[:lti_launches]
                     end

      source_tci_guid = params[:data][:tool_consumer_instance_guid]

      # For old exports the source tci_guid is missing so we try to look it up
      if source_tci_guid.blank?
        ims_export = ImsExport.find_by(token: data[:ims_export_id])
        source_tci_guid = ims_export&.tool_consumer_instance_guid
      end

      ims_import = ImsImport.create!(
        export_token: params[:data][:ims_export_id],
        context_id: params[:context_id],
        tci_guid: params[:tool_consumer_instance_guid],
        lms_course_id: params[:custom_canvas_course_id],
        source_context_id: params[:data][:context_id],
        source_tci_guid: source_tci_guid,
        payload: data,
      )

      data = {
        ims_import_id: ims_import.id,
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
