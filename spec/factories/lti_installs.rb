FactoryBot.define do
  factory :lti_install do
    client_id { generate(:lti_key) }
  end
end
