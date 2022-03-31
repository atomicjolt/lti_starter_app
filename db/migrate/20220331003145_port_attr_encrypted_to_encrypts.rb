class PortAttrEncryptedToEncrypts < ActiveRecord::Migration[7.0]
  def up
    # ApplicationInstance
    reload_application_instances_model
    ApplicationInstance.all.each do |u|
      # takes the attr_encrypted properties and puts in the Rails 7 properties
      # must do this programmatically because thats how encryption happens.
      # We can't shortcut this via a db command
      u.canvas_token = u.canvas_token_2
      u.save!
    end
    reload_application_instances_model

    # Authentication
    reload_authentication_model
    Authentication.all.each do |u|
      u.token = u.token_2
      u.secret = u.secret_2
      u.refresh_token = u.refresh_token_2
      u.save!
    end
    reload_authentication_model
  end

  def down
    # ApplicationInstance
    reload_application_instances_model
    ApplicationInstance.all.each do |u|
      # takes the Rails 7 properties and puts in the attr_encrypted properties
      # must do this programmatically because thats how encryption happens.
      # We can't shortcut this via a db command
      u.canvas_token_2 = u.canvas_token
      u.save!
    end
    reload_application_instances_model

    # Authentication
    reload_authentication_model
    Authentication.all.each do |u|
      u.token_2 = u.token
      u.secret_2 = u.secret
      u.refresh_token_2 = u.refresh_token
      u.save!
    end
    reload_authentication_model
  end

  def reload_application_instances_model
    # We must do this because of how the ApplicationInstance model is
    # dynamically defined
    ApplicationInstance.reset_column_information
    Object.send(:remove_const, "ApplicationInstance")
    load "app/models/application_instance.rb"
  end

  def reload_authentication_model
    # We must do this because of how the Authentication model is
    # dynamically defined
    Authentication.reset_column_information
    Object.send(:remove_const, "Authentication")
    load "app/models/authentication.rb"
  end
end
