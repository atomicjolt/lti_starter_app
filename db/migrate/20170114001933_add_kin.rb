class AddKin < ActiveRecord::Migration[4.2]
  def change
    add_column :applications, :kind, :integer, default: 0
  end
end
