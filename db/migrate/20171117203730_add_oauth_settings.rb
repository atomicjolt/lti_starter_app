class AddOauthSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :applications, :oauth_precedence, :string, default: "global,user,application_instance,course"
  end
end
