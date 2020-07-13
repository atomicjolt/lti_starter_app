FactoryBot.define do
  factory :lti_deployment do
    application_instance
    lti_install
    deployment_id { FactoryBot.generate(:deployment_id) }
  end
end
