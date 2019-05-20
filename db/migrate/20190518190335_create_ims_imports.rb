class CreateImsImports < ActiveRecord::Migration[5.1]
  def change
    create_table :ims_imports do |t|
      t.string :status, null: false, default: "initialized"
      t.string :error_message
      t.text :error_trace
      t.string :export_token
      t.string :context_id, null: false
      t.string :tci_guid, null: false
      t.string :lms_course_id, null: false
      t.string :source_context_id, null: false
      t.string :source_tci_guid, null: false

      t.timestamps
    end
  end
end
