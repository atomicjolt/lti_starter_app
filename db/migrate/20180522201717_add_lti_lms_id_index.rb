class AddLtiLmsIdIndex < ActiveRecord::Migration[5.1]
  def change
  	add_index :users, [:lms_user_id, :lti_user_id]
  end
end
