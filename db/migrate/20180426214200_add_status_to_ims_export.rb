class AddStatusToImsExport < ActiveRecord::Migration[5.1]
  def change
    add_column :ims_exports, :status, :string, default: "processing"
    add_column :ims_exports, :message, :string, limit: 2048
  end
end
