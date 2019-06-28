class LtiDeployment < ApplicationRecord
  belongs_to :application_instance
  validates :application_instance_id, presence: true
  validates :deployment_id, presence: true, uniqueness: true, uniqueness: { scope: %i[ application_instance_id ] }
end
