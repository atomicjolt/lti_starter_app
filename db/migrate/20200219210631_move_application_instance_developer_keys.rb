class MoveApplicationInstanceDeveloperKeys < ActiveRecord::Migration[5.2]
  def change
    remove_column :application_instances, :oauth_key, :string
    remove_column :application_instances, :oauth_secret, :string
    add_column :applications, :oauth_key, :string
    add_column :applications, :oauth_secret, :string
  end
end
