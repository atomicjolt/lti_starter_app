FactoryBot.define do
  factory :bundle do
    name { FactoryBot.generate(:name) }
    key { FactoryBot.generate(:lti_key) }
  end
end
