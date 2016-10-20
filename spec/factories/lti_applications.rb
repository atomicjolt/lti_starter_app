FactoryGirl.define do
  factory :lti_application do
    name { FactoryGirl.generate(:name) }
    lti_key { FactoryGirl.generate(:name) }
    lti_consumer_uri { FactoryGirl.generate(:domain) }
  end
end
