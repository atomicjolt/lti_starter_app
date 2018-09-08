class AddVisibilityToApplicationInstance < ActiveRecord::Migration[4.2]
  def change
    add_column :application_instances, :visibility, :integer, default: 0
  end
end
