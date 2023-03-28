# This migration comes from atomic_tenant (originally 20220816223258)
class CreateAtomicTenantPinnedClientIds < ActiveRecord::Migration[7.0]
  def change
    create_table :atomic_tenant_pinned_client_ids do |t|
      t.string :iss, null: false
      t.string :client_id, null: false

      t.bigint :application_instance_id, null: false

      t.timestamps
    end

    add_index :atomic_tenant_pinned_client_ids, [:iss, :client_id], unique: true
  end
end


