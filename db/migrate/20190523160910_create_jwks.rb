class CreateJwks < ActiveRecord::Migration[5.1]
  def change
    create_table :jwks do |t|
      t.string :kid
      t.string :pem
      t.timestamps
    end
    add_index :jwks, :kid
  end
end
