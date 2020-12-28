class CreateLtiPlatformInstances < ActiveRecord::Migration[5.2]
  def change
    create_table :lti_platform_instances do |t|
      t.string :guid, null: false
      t.string :iss, null: false
      t.string :name
      t.string :product_family_code
      t.timestamps
    end
    add_index :lti_platform_instances, [:guid, :iss], unique: true
  end
end
