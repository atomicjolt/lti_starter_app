class AddApplicationInstanceToJwk < ActiveRecord::Migration[5.1]
  def change
    add_column :jwks, :application_instance_id, :bigint
    add_index :jwks, :application_instance_id
  end
end
