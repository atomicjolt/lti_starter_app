class Api::ImsImportsController < ApplicationController
  include Concerns::CanvasImsccSupport

  def create
    params[:data][:lti_launches].each do |current_params|
      lti_launch_attrs = lti_launch_params(current_params)

      # Check to see if we already have an LTI Launch. If we do the user is likely importing the same content again.
      lti_launch = LtiLaunch.find_by(token: lti_launch_attrs[:token], context_id: params[:context_id])

      if lti_launch.blank?
        lti_launch = LtiLaunch.new(lti_launch_attrs)
        lti_launch.context_id = params[:context_id]
        lti_launch.tool_consumer_instance_guid = params[:tool_consumer_instance_guid]
        lti_launch.save!
      end
    end

    render json: { status: "completed" }
  end

  private

  def lti_launch_params(current_params)
    current_params.permit(
      :token,
      config: current_params[:config].try(:keys),
    )
  end

end
