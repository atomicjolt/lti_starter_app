# This migration comes from atomic_lti (originally 20220428175305)
class CreateAtomicLtiDeployments < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_deployments do |t|
      t.string :deployment_id, null: false
      t.string :client_id, null: false
      t.string :platform_guid
      t.string :iss, null: false
      t.timestamps
    end
    add_index :atomic_lti_deployments, [:deployment_id, :iss],
              unique: true, name: "index_atomic_lti_deployments_d_id_iss"
  end
end
