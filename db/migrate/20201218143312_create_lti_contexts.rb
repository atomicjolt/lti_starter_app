class CreateLtiContexts < ActiveRecord::Migration[5.2]
  def change
    create_table :lti_contexts do |t|
      t.string :context_id, null: false
      t.string :label
      t.string :title
      t.references :lti_deployment, foreign_key: true
      t.timestamps
    end
    add_index :lti_contexts, [:context_id, :lti_deployment_id], unique: true
  end
end
