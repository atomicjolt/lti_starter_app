class Bundle < ApplicationRecord
  has_many :application_bundles
  has_many :applications, through: :application_bundles

  scope :by_application_id, ->(application_id) { where(applications: { id: application_id }) }
end
