class AddTenantToApplicationInstance < ActiveRecord::Migration[4.2]
  def change
    add_column :application_instances, :tenant, :string
  end
end
