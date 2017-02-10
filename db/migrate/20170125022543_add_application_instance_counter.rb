class AddApplicationInstanceCounter < ActiveRecord::Migration
  def change
    add_column :applications, :application_instances_count, :integer
  end
end
