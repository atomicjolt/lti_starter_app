class RemoveAttrEncryptedColumns < ActiveRecord::Migration[7.0]
  def up
    # ApplicationInstance
    remove_column :application_instances, :encrypted_canvas_token_2
    remove_column :application_instances, :encrypted_canvas_token_2_iv
    remove_column :application_instances, :encrypted_canvas_token_2_salt

    # Authentication
    remove_column :authentications, :encrypted_token_2
    remove_column :authentications, :encrypted_token_2_iv
    remove_column :authentications, :encrypted_token_2_salt

    remove_column :authentications, :encrypted_secret_2
    remove_column :authentications, :encrypted_secret_2_iv
    remove_column :authentications, :encrypted_secret_2_salt

    remove_column :authentications, :encrypted_refresh_token_2
    remove_column :authentications, :encrypted_refresh_token_2_iv
    remove_column :authentications, :encrypted_refresh_token_2_salt
  end

  def down
    # ApplicationInstance
    add_column :application_instances, :encrypted_canvas_token_2, :string
    add_column :application_instances, :encrypted_canvas_token_2_iv, :string
    add_column :application_instances, :encrypted_canvas_token_2_salt, :string

    # Authentication
    add_column :application_instances, :encrypted_token_2, :string
    add_column :application_instances, :encrypted_token_2_iv, :string
    add_column :application_instances, :encrypted_token_2_salt, :string

    add_column :application_instances, :encrypted_secret_2, :string
    add_column :application_instances, :encrypted_secret_2_iv, :string
    add_column :application_instances, :encrypted_secret_2_salt, :string

    add_column :application_instances, :encrypted_refresh_token_2, :string
    add_column :application_instances, :encrypted_refresh_token_2_iv, :string
    add_column :application_instances, :encrypted_refresh_token_2_salt, :string
  end
end
