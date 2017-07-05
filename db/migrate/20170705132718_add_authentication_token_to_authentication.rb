class AddAuthenticationTokenToAuthentication < ActiveRecord::Migration[5.0]
  def change
    add_column :authentications, :id_token, :string
  end
end
