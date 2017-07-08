class AddDisabledToApplicationInstance < ActiveRecord::Migration[5.0]
  def change
    add_column :application_instances, :disabled_at, :datetime
  end
end
