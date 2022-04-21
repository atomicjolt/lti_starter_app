class ApiToken < ApplicationRecord
  attr_encrypted :secret, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt

  belongs_to :application_instance, optional: false
  belongs_to :user, inverse_of: :api_tokens, optional: false
  validates :key, uniqueness: true, presence: true
  validates :secret, presence: true

  before_validation(on: :create) do
    self.secret = SecureRandom.hex(64)
    self.key = SecureRandom.hex(12)
  end

  def self.make_api_user(
    application_instance:,
    email: "#{SecureRandom.hex(24)}@atomicjolt.com",
    password: SecureRandom.hex(48),
    user: nil,
    role: nil
  )
    user ||= User.create!(email: email, password: password)
    user.add_to_role(role || "api_user")

    user.confirm unless user.confirmed?
    token_params = {
      application_instance: application_instance,
      user: user,
    }
    api_token = user.api_tokens.create!(token_params)
    {
      api_token: api_token,
      user: user,
      application_instance_id: application_instance.id,
    }
  end
end
