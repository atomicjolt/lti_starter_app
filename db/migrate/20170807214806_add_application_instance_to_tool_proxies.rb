class AddApplicationInstanceToToolProxies < ActiveRecord::Migration[5.0]
  def change
    add_column :tool_proxies, :application_instance_id, :integer
    add_index :tool_proxies, :application_instance_id
  end
end
