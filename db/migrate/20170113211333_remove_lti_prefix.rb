class RemoveLtiPrefix < ActiveRecord::Migration
  def change
    rename_column :application_instances, :application_id, :application_id
    rename_table :applications, :applications
    rename_table :application_instances, :application_instances
  end
end
