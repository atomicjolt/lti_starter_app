class AddKin < ActiveRecord::Migration
  def change
    add_column :applications, :kind, :integer, default: 0
  end
end
