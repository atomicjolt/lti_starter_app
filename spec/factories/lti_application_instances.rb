FactoryGirl.define do
  factory :application_instance do
    application
    lti_key { FactoryGirl.generate(:lti_key) }
    lti_secret { FactoryGirl.generate(:password) }
    lti_consumer_uri { FactoryGirl.generate(:domain) }
    canvas_token { FactoryGirl.generate(:password) }
  end
end
