class AddAppInstDomain < ActiveRecord::Migration
  def change
    add_column :lti_application_instances, :domain, :string, limit: 2048
  end
end
