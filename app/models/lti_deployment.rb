class LtiDeployment < ApplicationRecord
  belongs_to :application_instance
  belongs_to :lti_install

  validates :application_instance_id, presence: true
  validates :deployment_id, presence: true, uniqueness: { scope: %i[application_instance_id] }
end
