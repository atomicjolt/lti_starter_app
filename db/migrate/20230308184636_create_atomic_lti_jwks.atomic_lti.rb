# This migration comes from atomic_lti (originally 20220503003528)
class CreateAtomicLtiJwks < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_jwks do |t|
      t.string :kid
      t.string :pem
      t.string :domain
      t.timestamps
    end
    add_index :atomic_lti_jwks, :kid
    add_index :atomic_lti_jwks, :domain
  end
end
