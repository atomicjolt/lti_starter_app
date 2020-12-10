class DefaultScopedDeveloperKeyOff < ActiveRecord::Migration[5.2]
  def change
    change_column :application_instances, :use_scoped_developer_key, :boolean, null: false, default: false
  end
end
