class FixLicenseSpelling < ActiveRecord::Migration[6.1]
  def change
    rename_column :application_instances, :licence_end_date, :license_end_date
  end
end
