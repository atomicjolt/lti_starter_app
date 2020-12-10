class LtiInstall < ApplicationRecord
  belongs_to :application
  has_many :lti_deployments, dependent: :restrict_with_exception

  validates :application_id, presence: true
  validates :client_id, presence: true, uniqueness: { scope: %i[iss] }
end
