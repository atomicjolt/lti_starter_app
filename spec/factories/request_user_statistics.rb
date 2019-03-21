FactoryBot.define do
  factory :request_user_statistic do
    truncated_time { generate(:truncated_time) }
    tenant { generate(:name) }
    user_id { generate(:user_id) }
  end
end
