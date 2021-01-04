class AddFieldsToLtiLaunches < ActiveRecord::Migration[5.2]
  def change
    add_column :lti_launches, :resource_link_id, :string, null: false, default: ''
    add_column :lti_launches, :title, :string
    add_column :lti_launches, :is_configured, :boolean, default: true
    add_column :lti_launches, :parent_id, :bigint
    add_reference :lti_launches, :lti_context, foreign_key: true
    add_reference :lti_launches, :application_instance, foreign_key: true
  end
end
