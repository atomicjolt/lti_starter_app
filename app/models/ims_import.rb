class ImsImport < ApplicationRecord
  validates :status, inclusion: {
    in: ["initialized", "started", "finished", "failed"],
  }
end
