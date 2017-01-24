class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url, limit: 2048
      t.string :oauth_key
      t.string :oauth_secret
      t.timestamps null: false
    end
    add_index :sites, :url

    add_column :application_instances, :site_id, :integer
    remove_column :application_instances, :lti_consumer_uri, :string
    add_index :application_instances, :site_id
  end
end
