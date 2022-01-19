class AddRegistrationClientUri < ActiveRecord::Migration[6.1]
  def change
    add_column :lti_installs, :registration_client_uri, :string
  end
end
