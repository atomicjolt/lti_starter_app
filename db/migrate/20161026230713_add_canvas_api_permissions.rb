class AddCanvasApiPermissions < ActiveRecord::Migration[4.2]
  def change
    add_column :lti_applications, :canvas_api_permissions, :text
  end
end
