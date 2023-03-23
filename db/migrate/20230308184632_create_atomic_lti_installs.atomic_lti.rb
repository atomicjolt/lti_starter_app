# This migration comes from atomic_lti (originally 20220428175247)
class CreateAtomicLtiInstalls < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_installs do |t|
      t.string :iss, null: false
      t.string :client_id, null: false
      t.timestamps
    end
    add_index :atomic_lti_installs, [:client_id, :iss],
              unique: true, name: "index_atomic_lti_installs_c_id_guid"
  end
end
