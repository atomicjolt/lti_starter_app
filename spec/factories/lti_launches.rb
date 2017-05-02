FactoryGirl.define do
  factory :lti_launch do
    config { { important_value: "something" }.to_json }
  end
end
