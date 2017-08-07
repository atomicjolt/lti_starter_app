class AddBundleInstanceEntityKey < ActiveRecord::Migration[5.0]
  def change
    def change
      add_column :bundle_instances, :entity_key, :string
    end
  end
end
