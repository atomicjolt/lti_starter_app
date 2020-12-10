class CreateLtiInstalls < ActiveRecord::Migration[5.1]
  def change
    create_table :lti_installs do |t|
      t.string :iss
      t.bigint :application_id
      t.string :client_id
      t.string :jwks_url
      t.string :token_url
      t.string :oidc_url
      t.timestamps
    end
    add_index :lti_installs, [:client_id, :iss], :unique => true
    add_index :lti_installs, :application_id
    add_index :lti_installs, :iss
    add_index :lti_installs, :client_id
    add_index :lti_installs, [:application_id, :iss]
  end
end
