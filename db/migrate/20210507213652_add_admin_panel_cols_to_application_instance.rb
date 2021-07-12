class AddAdminPanelColsToApplicationInstance < ActiveRecord::Migration[6.1]
  def change
    add_column :application_instances, :nickname, :string
    add_column :application_instances, :primary_contact, :string
  end
end
