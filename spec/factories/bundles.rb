FactoryBot.define do
  factory :bundle do
    name { FactoryBot.generate(:name) }
    key { ::SecureRandom::hex(15) }
  end
end
