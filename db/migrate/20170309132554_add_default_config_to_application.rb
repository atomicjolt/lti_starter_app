class AddDefaultConfigToApplication < ActiveRecord::Migration[4.2]
  def change
    add_column :applications, :default_config, :jsonb, default: {}
    add_column :application_instances, :config, :jsonb, default: {}
  end
end
