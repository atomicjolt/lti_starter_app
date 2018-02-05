class ImsExport < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer
end
