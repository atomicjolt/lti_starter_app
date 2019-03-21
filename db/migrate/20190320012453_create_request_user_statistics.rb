class CreateRequestUserStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :request_user_statistics, id: false do |t|
      t.datetime :truncated_time, null: false
      t.string :tenant, null: false
      t.bigint :user_id, null: false
    end

    reversible do |dir|
      dir.up do
        # add a PRIMARY KEY constraint
        execute <<-SQL
          ALTER TABLE request_user_statistics
            ADD CONSTRAINT request_user_statistics_pkey PRIMARY KEY (truncated_time, tenant, user_id)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE request_user_statistics
            DROP CONSTRAINT request_user_statistics_pkey
        SQL
      end
    end
  end
end
