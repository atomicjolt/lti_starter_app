# This migration comes from atomic_lti (originally 20220428175423)
class CreateAtomicLtiOauthStates < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_oauth_states do |t|
      t.string :state, null: false
      t.text :payload, null: false
      t.timestamps
    end
    add_index :atomic_lti_oauth_states, :state
  end
end
