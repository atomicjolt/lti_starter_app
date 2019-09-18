class CreateJwks < ActiveRecord::Migration[5.1]
  def change
    create_table :jwks do |t|
      t.string :kid
      t.string :pem
      t.bigint :application_id
      t.timestamps
    end
    add_index :jwks, :kid
    add_index :jwks, :application_id
  end
end
