class AddLegacyLtiUserIdIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :legacy_lti_user_id, unique: true
  end
end
