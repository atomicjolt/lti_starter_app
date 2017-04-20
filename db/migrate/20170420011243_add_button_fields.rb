class AddButtonFields < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :button_url, :string
    add_column :applications, :button_text, :string
  end
end
