FactoryGirl.define do
  factory :site do
    url { FactoryGirl.generate(:url) }
  end
end
