class AddMoreToLtiLaunches < ActiveRecord::Migration[5.0]
  def up
    add_column :lti_launches, :context_id, :string
    add_column :lti_launches, :tool_consumer_instance_guid, :string
    add_index :lti_launches, :context_id
  end
  def down
    remove_index :lti_launches, :context_id
    remove_column :lti_launches, :context_id
    remove_column :lti_launches, :tool_consumer_instance_guid
  end
end
