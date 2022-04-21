class RenameEncryptedColumns < ActiveRecord::Migration[7.0]
  def change
    # ApplicationInstance
    rename_column :application_instances, :encrypted_canvas_token, :encrypted_canvas_token_2
    rename_column :application_instances, :encrypted_canvas_token_iv, :encrypted_canvas_token_2_iv
    rename_column :application_instances, :encrypted_canvas_token_salt, :encrypted_canvas_token_2_salt

    # Authentication
    rename_column :authentications, :encrypted_token, :encrypted_token_2
    rename_column :authentications, :encrypted_token_iv, :encrypted_token_2_iv
    rename_column :authentications, :encrypted_token_salt, :encrypted_token_2_salt

    rename_column :authentications, :encrypted_secret, :encrypted_secret_2
    rename_column :authentications, :encrypted_secret_iv, :encrypted_secret_2_iv
    rename_column :authentications, :encrypted_secret_salt, :encrypted_secret_2_salt

    rename_column :authentications, :encrypted_refresh_token, :encrypted_refresh_token_2
    rename_column :authentications, :encrypted_refresh_token_iv, :encrypted_refresh_token_2_iv
    rename_column :authentications, :encrypted_refresh_token_salt, :encrypted_refresh_token_2_salt
  end
end
