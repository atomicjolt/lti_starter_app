class ImsImportJob < ApplicationJob
  retry_on StandardError, attempts: 16

  def perform(job_data)
    data = JSON.parse(job_data).with_indifferent_access
    ims_import = ImsImport.find(data[:ims_import_id])
    ims_import.update(status: "started")

    lti_launches = data[:lti_launches]
    context_id = data[:context_id]
    tool_consumer_instance_guid = data[:tool_consumer_instance_guid]

    lti_launches&.each do |lti_launch_attrs|
      # Check to see if we already have an LTI Launch. If we do the user is likely importing the same content again.
      lti_launch = LtiLaunch.find_by(token: lti_launch_attrs[:token], context_id: context_id)

      if lti_launch.blank?
        lti_launch = LtiLaunch.new(lti_launch_attrs)
        lti_launch.context_id = context_id
        lti_launch.tool_consumer_instance_guid = tool_consumer_instance_guid
        lti_launch.save!
      end
    end

    ims_import.update(status: "finished")
  rescue StandardError => e
    ims_import&.update(
      status: "failed",
      error_message: e.message,
      error_trace: e.backtrace,
    )
    raise e
  end
end
