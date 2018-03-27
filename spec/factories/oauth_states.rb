FactoryBot.define do
  factory :oauth_state do
    state { SecureRandom.hex(24) }
    payload { { url: "http://www.example.com" }.to_json }
  end
end
