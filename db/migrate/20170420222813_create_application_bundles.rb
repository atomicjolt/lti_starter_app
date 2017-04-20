class CreateApplicationBundles < ActiveRecord::Migration[5.0]
  def change
    create_table :application_bundles do |t|
      t.integer :application_id
      t.integer :bundle_id
      t.timestamps
    end
    add_index :application_bundles, [:application_id, :bundle_id]
  end
end
