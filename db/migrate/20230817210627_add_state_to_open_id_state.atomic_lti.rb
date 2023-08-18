# This migration comes from atomic_lti (originally 20230726040941)
class AddStateToOpenIdState < ActiveRecord::Migration[7.0]
  def change
    add_column :atomic_lti_open_id_states, :state, :string
    add_index :atomic_lti_open_id_states, :state, unique: true
  end
end
