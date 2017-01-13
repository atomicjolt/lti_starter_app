class AddCanvasApiPermissions < ActiveRecord::Migration
  def change
    add_column :applications, :canvas_api_permissions, :text
  end
end
