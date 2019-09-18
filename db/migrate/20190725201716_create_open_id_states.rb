class CreateOpenIdStates < ActiveRecord::Migration[5.1]
  def change
    create_table :open_id_states do |t|
      t.string :nonce
      t.timestamps
    end
    add_index :open_id_states, :nonce, unique: true
  end
end
