class LtiPlatformInstance < ApplicationRecord
  validates :iss, presence: true
  validates :guid, presence: true, uniqueness: { scope: %i[iss] }

  # Settings passed to client during launch
  def to_settings
    {
      guid: guid,
      name: name,
      product_family_code: product_family_code,
    }
  end
end
