class BundleInstanceEntityKey < ActiveRecord::Migration[5.0]
  def change
    add_column :bundle_instances, :entity_key, :string
  end
end
