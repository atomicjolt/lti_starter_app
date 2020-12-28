FactoryBot.define do
  factory :lti_context do
    context_id { "MyString" }
    label { "MyString" }
    title { "MyString" }
    type { "" }
    lti_platform { nil }
    lti_deployment { nil }
  end
end
