class LtiInstall < ApplicationRecord
  belongs_to :application
  validates :application_id, presence: true
  validates :client_id, presence: true, uniqueness: true
end
