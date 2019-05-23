class AddDeploymentId < ActiveRecord::Migration[5.1]
  def change
    add_column :application_instances, :deployment_id, :string
  end
end
