class AddSecureTokenToLtiContexts < ActiveRecord::Migration[5.2]
  def change
    add_column :lti_contexts, :secure_token, :string
  end
end
