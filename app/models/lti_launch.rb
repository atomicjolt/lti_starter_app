class LtiLaunch < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer
end
