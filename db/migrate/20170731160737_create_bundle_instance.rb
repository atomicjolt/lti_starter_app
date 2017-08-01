class CreateBundleInstance < ActiveRecord::Migration[5.0]
  def change
    create_table :bundle_instances do |t|
      t.integer :site_id
      t.integer :bundle_id
      t.timestamps
    end

    add_column :application_instances, :bundle_instance_id, :integer
    add_column :bundles, :key, :string
    add_index(:bundles, :key)
  end
end
