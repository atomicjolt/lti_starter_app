class AddLtiPlatformInstanceIdToLtiDeployments < ActiveRecord::Migration[5.2]
  def change
    add_reference :lti_deployments, :lti_platform_instance, foreign_key: true
  end
end
