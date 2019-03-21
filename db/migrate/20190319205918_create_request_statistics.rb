class CreateRequestStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :request_statistics, id: false do |t|
      t.datetime :truncated_time, null: false
      t.string :tenant, null: false
      t.integer :number_of_hits, default: 1
      t.integer :number_of_lti_launches, default: 0
      t.integer :number_of_errors, default: 0
    end

    reversible do |dir|
      dir.up do
        # add a PRIMARY KEY constraint
        execute <<-SQL
          ALTER TABLE request_statistics
            ADD CONSTRAINT request_statistics_pkey PRIMARY KEY (truncated_time, tenant)
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE request_statistics
            DROP CONSTRAINT request_statistics_pkey
        SQL
      end
    end
  end
end
