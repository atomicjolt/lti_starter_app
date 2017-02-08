namespace :canvas do
  desc "Sync students with Canvas"
  task sync_students: [:environment] do |_t, _args|
    Course.all.each(&:sync_students)
  end
end
