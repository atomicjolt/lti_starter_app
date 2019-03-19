FactoryBot.define do
  factory :request_log do
    request_id { generate(:uuid) }
    tenant { generate(:name) }
    user_id { generate(:user_id) }
    lti_launch { generate(:is_lti_launch) }
    error { generate(:is_error) }
    host { generate(:uri) }
  end
end
