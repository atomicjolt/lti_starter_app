class FixLtiLaunchesIndex < ActiveRecord::Migration[5.0]
  def up
    remove_index :lti_launches, :token
    add_index :lti_launches, [:token, :context_id], unique: true
  end

  def down
    remove_index :lti_launches, [:token, :context_id]
    add_index :lti_launches, :token, unique: true
  end
end
