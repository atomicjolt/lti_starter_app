FactoryBot.define do
  sequence :token do |n|
    "token_#{n}"
  end

  sequence :lti_key do |n|
    "lti_key_#{n}"
  end

  sequence :domain do |n|
    "www.example#{n}.com"
  end

  sequence :code do |n|
    "code#{n}"
  end

  sequence :name do |n|
    "user_#{n}"
  end

  sequence :email do |n|
    "user_#{n}@example.com"
  end

  sequence :password do
    Devise.friendly_token(20)
  end

  sequence :title do |n|
    "a_title#{n}"
  end

  sequence :abbr do |n|
    "a#{n}"
  end

  sequence :url do |n|
    "http://#{n}.example.com"
  end

  sequence :uri do |n|
    "n#{n}.example.com"
  end

  sequence :description do |n|
    "This is the description: #{n}"
  end

  sequence :locale do |n|
    "a#{n}"
  end

  sequence :address do |n|
    "#{n} West #{n} South"
  end

  sequence :position do |n|
    n
  end

  sequence :lms_course_id do |n|
    n + 32
  end

  sequence :parent_id do |n|
    n + 64
  end

  sequence :canvas_module_id do |n|
    n + 128
  end

  sequence :external_tool_id do |n|
    n + 256
  end

  sequence :account_id do |n|
    n + 512
  end

  sequence :module_type do |n|
    "module_type_#{n}"
  end

  sequence :filter_type do |n|
    "filter_type_#{n}"
  end

  sequence :workflow_state do
    ["active", "unpublished", "deleted"].sample
  end

  sequence :available_until do |n|
    n.days.from_now
  end

  sequence :uuid do
    SecureRandom.uuid
  end

  sequence :context_id do |n|
    "123aba321_#{n}"
  end

  sequence :client_id do |n|
    "1200000#{n}"
  end

  sequence :deployment_id do |n|
    "#{SecureRandom.hex}#{n}"
  end

  sequence :user_id do |n|
    n
  end

  sequence :truncated_time do |n|
    Time.zone.now - n.hours
  end

  sequence :number_of_hits do |n|
    (n % 50) * 100
  end

  sequence :number_of_lti_launches do |n|
    (n % 30) * 100
  end

  sequence :number_of_errors do |n|
    (n % 10) * 100
  end

  sequence :is_lti_launch do
    [true, true, true, true, true, false].sample
  end

  sequence :is_error do
    [true, false, false, false, false, false].sample
  end
end
