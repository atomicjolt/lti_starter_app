FactoryGirl.define do
  factory :site do
    url { FactoryGirl.generate(:domain) }
  end
end
