class ChangeLtiIntegerToBigint < ActiveRecord::Migration[5.0]
  def up
    change_column :application_bundles, :id, :bigint
    change_column :application_instances, :id, :bigint
    change_column :applications, :id, :bigint
    change_column :bundle_instances, :id, :bigint
    change_column :bundles, :id, :bigint
    change_column :canvas_courses, :id, :bigint
    change_column :lti_launches, :id, :bigint
    change_column :nonces, :id, :bigint
    change_column :oauth_states, :id, :bigint
    change_column :sites, :id, :bigint

    change_column :application_bundles, :application_id, :bigint
    change_column :application_bundles, :bundle_id, :bigint
    change_column :application_instances, :application_id, :bigint
    change_column :application_instances, :site_id, :bigint
    change_column :application_instances, :bundle_instance_id, :bigint
    change_column :applications, :kind, :bigint
    change_column :applications, :application_instances_count, :bigint
    change_column :authentications, :application_instance_id, :bigint
    change_column :authentications, :canvas_course_id, :bigint
    change_column :bundle_instances, :site_id, :bigint
    change_column :bundle_instances, :bundle_id, :bigint
  end

  def down
    change_column :application_bundles, :id, :integer
    change_column :application_instances, :id, :integer
    change_column :applications, :id, :integer
    change_column :bundle_instances, :id, :integer
    change_column :bundles, :id, :integer
    change_column :canvas_courses, :id, :integer
    change_column :lti_launches, :id, :integer
    change_column :nonces, :id, :integer
    change_column :oauth_states, :id, :integer
    change_column :sites, :id, :integer

    change_column :application_bundles, :application_id, :integer
    change_column :application_bundles, :bundle_id, :integer
    change_column :application_instances, :application_id, :integer
    change_column :application_instances, :site_id, :integer
    change_column :application_instances, :bundle_instance_id, :integer
    change_column :applications, :kind, :integer
    change_column :applications, :application_instances_count, :integer
    change_column :authentications, :application_instance_id, :integer
    change_column :authentications, :canvas_course_id, :integer
    change_column :bundle_instances, :site_id, :integer
    change_column :bundle_instances, :bundle_id, :integer
  end
end
