class AddIndexToAppInstance < ActiveRecord::Migration[5.0]
  def change
    add_index :application_instances, :lti_key
  end
end
