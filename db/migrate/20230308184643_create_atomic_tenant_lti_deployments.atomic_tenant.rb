# This migration comes from atomic_tenant (originally 20220816154357)
class CreateAtomicTenantLtiDeployments < ActiveRecord::Migration[7.0]
  def change
    create_table :atomic_tenant_lti_deployments do |t|
      t.string :iss, null: false
      t.string :deployment_id, null: false
      t.bigint :application_instance_id, null: false
      t.timestamps
    end


    add_index :atomic_tenant_lti_deployments, [:iss, :deployment_id], unique: true
  end
end
