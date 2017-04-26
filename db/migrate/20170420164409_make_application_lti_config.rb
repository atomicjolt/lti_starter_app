class MakeApplicationLtiConfig < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :lti_config, :jsonb

    remove_column :applications, :visibility, :integer
    remove_column :applications, :lti_type, :integer
    remove_column :applications, :button_url, :string
    remove_column :applications, :button_text, :string

    remove_column :application_instances, :lti_type, :integer
    remove_column :application_instances, :visibility, :integer
  end
end
