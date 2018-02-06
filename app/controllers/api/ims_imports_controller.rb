class Api::ImsImportsController < ApplicationController
  include Concerns::CanvasImsccSupport

  def create
    original_application_instance = ApplicationInstance.find(params[:data][:application_instance_id])
    new_lti_launches = Apartment::Tenant.switch(original_application_instance.tenant) do
      lti_launches = LtiLaunch.where(token: params[:data][:lti_launch_tokens])
      lti_launches.map(&:dup)
    end

    new_lti_launches.each do |lti_launch|
      # Create a new lti_launch in the new tenant with the new tool_consumer_instance_guid and context_id
      lti_launch.context_id = params[:context_id]
      lti_launch.tool_consumer_instance_guid = params[:tool_consumer_instance_guid]
      lti_launch.save!
    end

    render json: { status: "completed" }
  end
end
