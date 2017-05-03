class AddLtiLaunchToken < ActiveRecord::Migration[5.0]
  def change
    add_column :lti_launches, :token, :string
    add_index :lti_launches, :token, unique: true
  end
end
