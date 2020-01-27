class AddApplicationInstanceOauthParams < ActiveRecord::Migration[5.2]
  def change
    add_column :application_instances, :oauth_key, :string
    add_column :application_instances, :oauth_secret, :string
    add_column :application_instances, :oauth_scopes, :string, array: true, default: []
  end
end
