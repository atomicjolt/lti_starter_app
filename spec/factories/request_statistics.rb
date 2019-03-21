FactoryBot.define do
  factory :request_statistic do
    truncated_time { generate(:truncated_time) }
    tenant { generate(:name) }
    number_of_hits { generate(:number_of_hits) }
    number_of_lti_launches { generate(:number_of_lti_launches) }
    number_of_errors { generate(:number_of_errors) }
  end
end
