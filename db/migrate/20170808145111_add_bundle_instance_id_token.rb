class AddBundleInstanceIdToken < ActiveRecord::Migration[5.0]
  def change
    add_column :bundle_instances, :id_token, :string
    add_index(:bundle_instances, :id_token)
  end
end
