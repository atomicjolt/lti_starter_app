class Nonce < ApplicationRecord

  def self.valid?(nonce)
    create!(nonce: nonce)
    true
  rescue
    Rails.logger.warn("Failed to create nonce: #{nonce}")
    false
  end

  # Remove old nonces from db. Run this from a background task to
  # clean the db of extraneous data.
  def self.clean
    delete_all(["created_at < ?", Time.now - 6.hours])
  end

end
