class CreateRequestLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :request_logs do |t|
      t.string :request_id
      t.string :tenant
      t.string :user_id
      t.boolean :lti_launch, default: false
      t.boolean :error, default: false
      t.string :host

      t.timestamps
    end

    add_index :request_logs, :request_id, unique: true
    add_index :request_logs, [:created_at, :tenant, :user_id]
  end
end
