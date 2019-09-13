class AddRollbarEnabledToApps < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :rollbar_enabled, :boolean, default: true
    add_column :application_instances, :rollbar_enabled, :boolean, default: true
  end
end
