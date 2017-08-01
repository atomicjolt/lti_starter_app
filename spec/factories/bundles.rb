FactoryGirl.define do
  factory :bundle do
    name { FactoryGirl.generate(:name) }
    key { FactoryGirl.generate(:lti_key) }
  end
end
