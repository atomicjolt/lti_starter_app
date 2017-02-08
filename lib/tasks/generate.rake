namespace :generate do
  desc "Seed the system with users"
  task :users, [:users, :id] => [:environment] do |_t, args|
    i = 0
    users = args.users.to_i || 1
    while i < users
      puts User.create!(FactoryGirl.attributes_for(:user))
      i += 1
    end
    puts "Created #{users} users"
  end
end
