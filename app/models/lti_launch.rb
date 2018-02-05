class LtiLaunch < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer

  validates :token,
            uniqueness: {
              scope: %i[
                context_id
              ],
            }
end
