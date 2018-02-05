class Api::ImsExportsController < ApplicationController

  include Concerns::CanvasImsccSupport

  def show
    @export = ImsExport.find_by(token: params[:id])
    respond_to do |format|
      format.json { render json: @export.payload.merge(ims_export_id: @export.token) }
    end
  end

  def status
    respond_to do |format|
      format.json { render json: { status: "completed" } }
    end
  end

  def create
    lti_launches = LtiLaunch.where(context_id: params[:context_id])
    payload = {
      application_instance_id: current_application_instance.id,
      context_id: params[:context_id],
      lti_launch_tokens: lti_launches.pluck(:token),
    }
    @export = ImsExport.create!(
      tool_consumer_instance_guid: params[:tool_consumer_instance_guid],
      context_id: params[:context_id],
      custom_canvas_course_id: params[:custom_canvas_course_id],
      payload: payload,
    )
    response = {
      "status_url": status_api_ims_export_url(@export.token),
      "fetch_url": api_ims_export_url(@export.token),
    }
    respond_to do |format|
      format.json { render json: response }
    end
  end

end
