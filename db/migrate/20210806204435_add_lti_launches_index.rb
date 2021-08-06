class AddLtiLaunchesIndex < ActiveRecord::Migration[6.1]
  def change
    add_index :lti_launches, :resource_link_id
  end
end
