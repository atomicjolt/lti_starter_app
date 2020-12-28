class LtiPlatformInstance < ApplicationRecord
  validates :iss, presence: true
  validates :guid, presence: true, uniqueness: { scope: %i[iss] }
end
