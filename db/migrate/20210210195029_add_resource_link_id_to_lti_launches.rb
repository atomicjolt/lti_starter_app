class AddResourceLinkIdToLtiLaunches < ActiveRecord::Migration[5.2]
  def change
    add_column :lti_launches, :resource_link_id, :string
  end
end
