class AnonymousLti < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :anonymous, :bool, default: false
    add_column :application_instances, :anonymous, :bool, default: false
  end
end
