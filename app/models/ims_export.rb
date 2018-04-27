class ImsExport < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer

  PROCESSING = "processing".freeze
  FAILED = "failed".freeze
  COMPLETED = "completed".freeze

  def processing?
    status == PROCESSING
  end

  def failed?
    status == FAILED
  end

  def completed?
    status == COMPLETED
  end
end
