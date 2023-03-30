# This migration comes from atomic_lti1v1 (originally 20220507041217)
class CreateAtomicLti1v1Nonces < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti1v1_nonces do |t|
      t.string 'nonce'
      t.timestamps
      t.index ['nonce'], name: 'index_atomic_lti1v1_nonces_on_nonce', unique: true
    end
  end
end
