FactoryGirl.define do
  factory :lti_application do
    name { FactoryGirl.generate(:name) }
    canvas_api_permissions "LIST_ACCOUNTS,LIST_ACCOUNT_ADMINS"
  end
end
