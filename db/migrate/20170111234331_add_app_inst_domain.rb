class AddAppInstDomain < ActiveRecord::Migration[4.2]
  def change
    add_column :lti_application_instances, :domain, :string, limit: 2048
  end
end
