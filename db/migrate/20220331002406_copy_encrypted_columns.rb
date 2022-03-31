class CopyEncryptedColumns < ActiveRecord::Migration[7.0]
  def up
    # ApplicationInstance
    ApplicationInstance.update_all("encrypted_canvas_token_2=encrypted_canvas_token")
    ApplicationInstance.update_all("encrypted_canvas_token_2_iv=encrypted_canvas_token_iv")
    ApplicationInstance.update_all("encrypted_canvas_token_2_salt=encrypted_canvas_token_salt")
    remove_column :application_instances, :encrypted_canvas_token
    remove_column :application_instances, :encrypted_canvas_token_iv
    remove_column :application_instances, :encrypted_canvas_token_salt

    # Authentication
    Authentication.update_all("encrypted_token_2=encrypted_token")
    Authentication.update_all("encrypted_token_2_iv=encrypted_token_iv")
    Authentication.update_all("encrypted_token_2_salt=encrypted_token_salt")
    remove_column :authentications, :encrypted_token
    remove_column :authentications, :encrypted_token_iv
    remove_column :authentications, :encrypted_token_salt

    Authentication.update_all("encrypted_secret_2=encrypted_secret")
    Authentication.update_all("encrypted_secret_2_iv=encrypted_secret_iv")
    Authentication.update_all("encrypted_secret_2_salt=encrypted_secret_salt")
    remove_column :authentications, :encrypted_secret
    remove_column :authentications, :encrypted_secret_iv
    remove_column :authentications, :encrypted_secret_salt

    Authentication.update_all("encrypted_refresh_token_2=encrypted_refresh_token")
    Authentication.update_all("encrypted_refresh_token_2_iv=encrypted_refresh_token_iv")
    Authentication.update_all("encrypted_refresh_token_2_salt=encrypted_refresh_token_salt")
    remove_column :authentications, :encrypted_refresh_token
    remove_column :authentications, :encrypted_refresh_token_iv
    remove_column :authentications, :encrypted_refresh_token_salt
  end

  def down
    # ApplicationInstance
    add_column :application_instances, :encrypted_canvas_token, :string
    add_column :application_instances, :encrypted_canvas_token_iv, :string
    add_column :application_instances, :encrypted_canvas_token_salt, :string
    ApplicationInstance.update_all("encrypted_canvas_token=encrypted_canvas_token_2")
    ApplicationInstance.update_all("encrypted_canvas_token_iv=encrypted_canvas_token_2_iv")
    ApplicationInstance.update_all("encrypted_canvas_token_salt=encrypted_canvas_token_2_salt")

    # Authentication
    add_column :authentications, :encrypted_token, :string
    add_column :authentications, :encrypted_token_iv, :string
    add_column :authentications, :encrypted_token_salt, :string
    Authentication.update_all("encrypted_token=encrypted_token_2")
    Authentication.update_all("encrypted_token_iv=encrypted_token_2_iv")
    Authentication.update_all("encrypted_token_salt=encrypted_token_2_salt")

    add_column :authentications, :encrypted_secret, :string
    add_column :authentications, :encrypted_secret_iv, :string
    add_column :authentications, :encrypted_secret_salt, :string
    Authentication.update_all("encrypted_secret=encrypted_secret_2")
    Authentication.update_all("encrypted_secret_iv=encrypted_secret_2_iv")
    Authentication.update_all("encrypted_secret_salt=encrypted_secret_2_salt")

    add_column :authentications, :encrypted_refresh_token, :string
    add_column :authentications, :encrypted_refresh_token_iv, :string
    add_column :authentications, :encrypted_refresh_token_salt, :string
    Authentication.update_all("encrypted_refresh_token=encrypted_refresh_token_2")
    Authentication.update_all("encrypted_refresh_token_iv=encrypted_refresh_token_2_iv")
    Authentication.update_all("encrypted_refresh_token_salt=encrypted_refresh_token_2_salt")
  end
end
