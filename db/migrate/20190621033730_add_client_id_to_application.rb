class AddClientIdToApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :client_id, :string
  end
end
