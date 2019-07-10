class AddLtiAdvantageJson < ActiveRecord::Migration[5.1]
  def change
    add_column :applications, :lti_advantage_config, :jsonb, default: {}
  end
end
