class AddNewEncryptedColumns < ActiveRecord::Migration[7.0]
  def change
    # ApplicationInstance
    add_column :application_instances, :canvas_token, :text

    # Authentication
    add_column :authentications, :token, :text
    add_column :authentications, :secret, :text
    add_column :authentications, :refresh_token, :text
  end
end
