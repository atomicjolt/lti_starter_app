FactoryGirl.define do
  factory :application_instance do
    application
    lti_key { FactoryGirl.generate(:lti_key) }
    lti_secret { FactoryGirl.generate(:password) }
    site
    canvas_token { FactoryGirl.generate(:password) }
  end
end
