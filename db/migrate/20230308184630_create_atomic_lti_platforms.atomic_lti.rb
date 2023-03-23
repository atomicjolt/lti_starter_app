# This migration comes from atomic_lti (originally 20220428175127)
class CreateAtomicLtiPlatforms < ActiveRecord::Migration[6.1]
  def change
    create_table :atomic_lti_platforms do |t|
      t.string :iss, null: false
      t.string :jwks_url, null: false
      t.string :token_url, null: false
      t.string :oidc_url, null: false
      t.timestamps
    end
    add_index :atomic_lti_platforms, :iss, unique: true
  end
end
