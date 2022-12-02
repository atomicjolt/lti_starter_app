class RemoveBundles < ActiveRecord::Migration[7.0]
  def change
    drop_table :bundles
    drop_table :bundle_instances
    drop_table :application_bundles

    remove_column :application_instances, :bundle_instance_id, :integer
  end
end
