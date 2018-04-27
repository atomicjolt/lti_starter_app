class Api::ImsExportsController < ApplicationController

  include Concerns::CanvasImsccSupport

  def show
    export = ImsExport.find_by(token: params[:id])
    respond_to do |format|
      format.json { render json: export.payload.merge(ims_export_id: export.token) }
    end
  end

  def status
    export = ImsExport.find_by(token: params[:id])
    respond_to do |format|
      format.json do
        render json: { status: export.status, message: export.message }
      end
    end
  end

  def create
    export = ImsExport.create!(
      tool_consumer_instance_guid: params[:tool_consumer_instance_guid],
      context_id: params[:context_id],
      custom_canvas_course_id: params[:custom_canvas_course_id],
    )
    ImsExportJob.perform_later(
      export,
      current_application_instance,
      ims_export_params.to_json,
    )
    response = {
      "status_url": status_api_ims_export_url(export.token),
      "fetch_url": api_ims_export_url(export.token),
    }
    respond_to do |format|
      format.json { render json: response }
    end
  end

  private

  def ims_export_params
    params.
      permit(
        :context_id,
        :tool_consumer_instance_guid,
        :custom_canvas_course_id,
      )
  end
end
