class AddAdminPanelColsToApplicationInstance < ActiveRecord::Migration[6.1]
  def change
    add_column :application_instances, :nickname, :string
    add_column :application_instances, :primary_contact, :string
    add_column :application_instances, :license_start_date, :datetime
    add_column :application_instances, :licence_end_date, :datetime
    add_column :application_instances, :trial_start_date, :datetime
    add_column :application_instances, :trial_end_date, :datetime
    add_column :application_instances, :license_notes, :text
    add_column :application_instances, :trial_notes, :text
  end
end
