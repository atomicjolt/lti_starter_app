FactoryGirl.define do
  factory :lti_application_instance do
    lti_application
    lti_key { FactoryGirl.generate(:name) }
    lti_consumer_uri { FactoryGirl.generate(:domain) }
  end
end
