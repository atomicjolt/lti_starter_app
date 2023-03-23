# This migration comes from atomic_lti (originally 20220428175336)
class CreateAtomicLtiContexts < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_contexts do |t|
      t.string :context_id, null: false
      t.string :deployment_id, null: false
      t.string :iss, null: false
      t.string :label
      t.string :title
      t.string :types, array: true
      t.timestamps
    end
    add_index :atomic_lti_contexts, [:context_id, :deployment_id, :iss],
              unique: true, name: "index_atomic_lti_contexts_c_id_d_id_iss"
  end
end
