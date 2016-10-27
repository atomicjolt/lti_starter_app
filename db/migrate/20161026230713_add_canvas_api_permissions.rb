class AddCanvasApiPermissions < ActiveRecord::Migration
  def change
    add_column :lti_applications, :canvas_api_permissions, :text
  end
end
