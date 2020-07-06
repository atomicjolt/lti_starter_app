class AddLtiInstallIdToLtiDeployments < ActiveRecord::Migration[5.2]
  def change
    add_reference :lti_deployments, :lti_install, foreign_key: true
  end
end
