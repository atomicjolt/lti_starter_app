class AddImsImportPayload < ActiveRecord::Migration[5.1]
  def change
    add_column :ims_imports, :payload, :jsonb
  end
end
