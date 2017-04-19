class AddLtiTypeToApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :lti_type, :integer, default: 0
    add_column :applications, :visibility, :integer, default: 0
  end
end
