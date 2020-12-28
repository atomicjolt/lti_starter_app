class LtiContext < ApplicationRecord
  belongs_to :lti_deployment
  validates :context_id, presence: true, uniqueness: { scope: %i[lti_deployment_id] }
end
