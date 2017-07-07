FactoryGirl.define do
  factory :site do
    url { "https://#{FactoryGirl.generate(:domain)}" }
  end
end
