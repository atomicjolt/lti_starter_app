class CreateApplicationInstances < ActiveRecord::Migration
  def change
    create_table :application_instances do |t|
      t.integer  :application_id
      t.string   :lti_key
      t.string   :lti_secret
      t.integer  :lti_type, default: 0
      t.string   :lti_consumer_uri
      t.string   :encrypted_canvas_token
      t.string   :encrypted_canvas_token_salt
      t.string   :encrypted_canvas_token_iv
      t.timestamps null: false
    end
    add_index :application_instances, :application_id
    remove_column :applications, :lti_key
    remove_column :applications, :lti_secret
    remove_column :applications, :lti_type
    remove_column :applications, :lti_consumer_uri
    remove_column :applications, :encrypted_canvas_token
    remove_column :applications, :encrypted_canvas_token_salt
    remove_column :applications, :encrypted_canvas_token_iv
  end
end
