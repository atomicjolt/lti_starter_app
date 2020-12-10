FactoryBot.define do
  factory :application_instance do
    application
    lti_key { FactoryBot.generate(:lti_key) }
    lti_secret { FactoryBot.generate(:password) }
    site
    canvas_token { FactoryBot.generate(:password) }
    bundle_instance
  end
end
