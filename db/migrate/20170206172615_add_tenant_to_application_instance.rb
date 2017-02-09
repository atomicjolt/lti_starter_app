class AddTenantToApplicationInstance < ActiveRecord::Migration
  def change
    add_column :application_instances, :tenant, :string
  end
end
