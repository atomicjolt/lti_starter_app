class AddApplicationScopes < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :oauth_scopes, :string, array: true, default: []
    add_column :application_instances, :use_scoped_developer_key, :boolean, null: false, default: :false
    remove_column :application_instances, :oauth_scopes, :string, array: true, default: []
  end
end
