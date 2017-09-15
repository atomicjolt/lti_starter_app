class AddSharedTenantToBundles < ActiveRecord::Migration[5.0]
  def change
    add_column :bundles, :shared_tenant, :boolean, default: false
  end
end
