FactoryBot.define do
  factory :open_id_state do
    nonce { SecureRandom.hex(64) }
  end
end
