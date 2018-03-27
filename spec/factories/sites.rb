FactoryBot.define do
  factory :site do
    url { FactoryBot.generate(:url) }
  end
end
