class AddLti13 < ActiveRecord::Migration[5.1]
  def change
    add_column :application_instances, :client_id, :string
    add_index :application_instances, [:client_id, :deployment_id]

    add_column :application_instances, :lti_jwks_url, :string
    add_column :application_instances, :lti_token_url, :string
  end
end
