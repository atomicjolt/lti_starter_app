class ImsExportJob < ApplicationJob
  retry_on StandardError, attempts: 16

  def perform(
    export,
    application_instance,
    ims_export_params
  )
    params = JSON.parse(ims_export_params).with_indifferent_access

    lti_launches = LtiLaunch.where(context_id: params[:context_id])

    lti_launches_payloads = lti_launches.find_each.map do |lti_launch|
      payload_lti_launch_json(lti_launch)
    end

    payload = {
      export_token: export.token,
      application_instance_id: application_instance.id,
      context_id: params[:context_id],
      tool_consumer_instance_guid: params[:tool_consumer_instance_guid],
      lti_launches: lti_launches_payloads.compact,
    }

    export.update(
      payload: payload,
      status: ImsExport::COMPLETED,
    )
  end

  def payload_lti_launch_json(lti_launch)
    {
      config: lti_launch.config,
      token: lti_launch.token,
      context_id: lti_launch.context_id,
      tool_consumer_instance_guid: lti_launch.tool_consumer_instance_guid,
    }
  end
end
