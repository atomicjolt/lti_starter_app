FactoryBot.define do
  factory :lti_install do
    application
    client_id { generate(:client_id) }
  end
end
