class OpenIdState < ApplicationRecord
  validates :nonce, presence: true, uniqueness: true
end
