FactoryGirl.define do
  factory :ims_export do
    payload { { important_value: "something" } }
  end
end
