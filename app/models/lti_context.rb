class LtiContext < ApplicationRecord
  belongs_to :lti_deployment
  validates :context_id, presence: true, uniqueness: { scope: %i[lti_deployment_id] }

  # Settings passed to client during launch
  def to_settings
    {
      context_id: context_id,
      label: label,
      title: title,
      platform_instance: lti_deployment.lti_platform_instance&.to_settings,
    }
  end
end
