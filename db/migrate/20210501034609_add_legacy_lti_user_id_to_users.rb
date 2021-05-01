class AddLegacyLtiUserIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :legacy_lti_user_id, :string
  end
end
