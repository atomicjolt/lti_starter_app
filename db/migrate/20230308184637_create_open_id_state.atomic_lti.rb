# This migration comes from atomic_lti (originally 20221010140920)
class CreateOpenIdState < ActiveRecord::Migration[7.0]
  def change
    create_table :atomic_lti_open_id_states do |t|
      t.string :nonce
      t.timestamps
    end
    add_index :atomic_lti_open_id_states, :nonce, unique: true
  end
end
