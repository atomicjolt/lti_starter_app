class AddVisibilityToApplicationInstance < ActiveRecord::Migration
  def change
    add_column :application_instances, :visibility, :integer, default: 0
  end
end
