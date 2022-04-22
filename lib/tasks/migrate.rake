def up
  puts "Moving data from attr_encrypted fields to Rails 7 fields"
  # ApplicationInstance
  ApplicationInstance.all.each do |u|
    # takes the attr_encrypted properties and puts in the Rails 7 properties
    # must do this programmatically because thats how encryption happens.
    # We can't shortcut this via a db command
    u.canvas_token = u.canvas_token_2
    u.save!
  end

  # Authentication
  Authentication.all.each do |u|
    u.token = u.token_2
    u.secret = u.secret_2
    u.refresh_token = u.refresh_token_2
    u.save!
  end
  puts "Done"
end

def down
  puts "Moving data from Rails 7 fields to attr_encrypted fields"
  # ApplicationInstance
  ApplicationInstance.all.each do |u|
    # takes the Rails 7 properties and puts in the attr_encrypted properties
    # must do this programmatically because thats how encryption happens.
    # We can't shortcut this via a db command
    u.canvas_token_2 = u.canvas_token
    u.save!
  end

  # Authentication
  Authentication.all.each do |u|
    u.token_2 = u.token
    u.secret_2 = u.secret
    u.refresh_token_2 = u.refresh_token
    u.save!
  end
  puts "Done"
end

namespace :migrate do
  desc "move data from attr_encrypted columns into new Rails 7 encrypted columns"
  task encrypted_up: :environment do
    up
  end

  desc "rolls back changes made by migrate task"
  task encrypted_down: :environment do
    down
  end
end
