class AddSecretToSite < ActiveRecord::Migration[5.0]
  def change
    add_column :sites, :secret, :string
  end
end
