class AddApplicationInstanceCounter < ActiveRecord::Migration[4.2]
  def change
    add_column :applications, :application_instances_count, :integer
  end
end
