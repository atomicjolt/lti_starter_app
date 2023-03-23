# This migration comes from atomic_lti (originally 20220428175128)
class CreateAtomicLtiPlatformInstances < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_platform_instances do |t|
      t.string :iss, null: false
      t.string :guid, null: false
      t.string :name
      t.string :version
      t.string :product_family_code

      t.timestamps
    end
    add_index :atomic_lti_platform_instances, [:guid, :iss],
              unique: true, name: "index_atomic_lti_platform_instances_guid_iss"
  end
end
