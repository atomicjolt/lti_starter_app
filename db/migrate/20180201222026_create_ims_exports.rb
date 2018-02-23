class CreateImsExports < ActiveRecord::Migration[5.0]
  def change
    create_table :ims_exports do |t|
      t.string :token
      t.string :tool_consumer_instance_guid
      t.string :context_id
      t.string :custom_canvas_course_id
      t.jsonb :payload
      t.timestamps
    end
    add_index :ims_exports, :token
  end
end
