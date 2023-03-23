FactoryBot.define do
  factory :authentication do
    user
    provider { FactoryBot.generate(:name) }
    token { FactoryBot.generate(:name) }
    secret { FactoryBot.generate(:password) }
    provider_url { FactoryBot.generate(:uri) }

    factory :authentication_canvas do
      provider { "canvas" }
      uid { "12345" }
      provider_url { "https://example.instructure.com" }
    end
  end
end
