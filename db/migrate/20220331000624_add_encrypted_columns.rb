class AddEncryptedColumns < ActiveRecord::Migration[7.0]
  def change
    # ApplicationInstance
    add_column :application_instances, :encrypted_canvas_token_2, :string
    add_column :application_instances, :encrypted_canvas_token_2_iv, :string
    add_column :application_instances, :encrypted_canvas_token_2_salt, :string

    # Authentication
    add_column :authentications, :encrypted_token_2, :string
    add_column :authentications, :encrypted_token_2_iv, :string
    add_column :authentications, :encrypted_token_2_salt, :string

    add_column :authentications, :encrypted_secret_2, :string
    add_column :authentications, :encrypted_secret_2_iv, :string
    add_column :authentications, :encrypted_secret_2_salt, :string

    add_column :authentications, :encrypted_refresh_token_2, :string
    add_column :authentications, :encrypted_refresh_token_2_iv, :string
    add_column :authentications, :encrypted_refresh_token_2_salt, :string
  end
end
