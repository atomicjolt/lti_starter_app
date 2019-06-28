class CreateLtiDeployments < ActiveRecord::Migration[5.1]
  def change
    create_table :lti_deployments do |t|
      t.bigint :application_instance_id
      t.string :deployment_id
      t.timestamps
    end
    add_index :lti_deployments, :application_instance_id
    add_index :lti_deployments, :deployment_id
    add_index :lti_deployments, [:deployment_id, :application_instance_id], unique: true, name: "index_lti_deployments_on_d_id_and_ai_id"
  end
end
