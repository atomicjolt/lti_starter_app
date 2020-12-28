class FixLtiLaunchesIndexForResourceLinkId < ActiveRecord::Migration[5.2]
  def up
    remove_index :lti_launches, [:token, :context_id]
    add_index :lti_launches,
      [:token, :context_id, :resource_link_id, :application_instance_id],
      unique: true,
      name: :index_lti_launches_on_launch
  end

  def down
    remove_index :lti_launches,
      [:token, :context_id, :resource_link_id, :application_instance_id]
    add_index :lti_launches, [:token, :context_id], unique: true
  end
end
