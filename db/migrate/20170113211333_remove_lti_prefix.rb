class RemoveLtiPrefix < ActiveRecord::Migration
  def change
    rename_column :lti_application_instances, :lti_application_id, :application_id
    rename_table :lti_applications, :applications
    rename_table :lti_application_instances, :application_instances
  end
end
