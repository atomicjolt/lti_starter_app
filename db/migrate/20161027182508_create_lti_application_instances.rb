class CreateLtiApplicationInstances < ActiveRecord::Migration[4.2]
  def change
    create_table :lti_application_instances do |t|
      t.integer  :lti_application_id
      t.string   :lti_key
      t.string   :lti_secret
      t.integer  :lti_type, default: 0
      t.string   :lti_consumer_uri
      t.string   :encrypted_canvas_token
      t.string   :encrypted_canvas_token_salt
      t.string   :encrypted_canvas_token_iv
      t.timestamps null: false
    end
    add_index :lti_application_instances, :lti_application_id
    remove_column :lti_applications, :lti_key
    remove_column :lti_applications, :lti_secret
    remove_column :lti_applications, :lti_type
    remove_column :lti_applications, :lti_consumer_uri
    remove_column :lti_applications, :encrypted_canvas_token
    remove_column :lti_applications, :encrypted_canvas_token_salt
    remove_column :lti_applications, :encrypted_canvas_token_iv
  end
end
