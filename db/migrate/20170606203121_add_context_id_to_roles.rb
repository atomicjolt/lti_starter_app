class AddContextIdToRoles < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :context_id, :integer
  end
end
