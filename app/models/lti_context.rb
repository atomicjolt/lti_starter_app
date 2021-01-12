class LtiContext < ApplicationRecord
  belongs_to :lti_deployment
  has_secure_token :secure_token

  validates :context_id, presence: true, uniqueness: { scope: %i[lti_deployment_id] }

  # Settings passed to client during launch
  def to_settings(can_author)
    {
      context_id: context_id,
      label: label,
      title: title,
      secure_token: (secure_token if can_author),
      platform_instance: lti_deployment.lti_platform_instance&.to_settings,
    }.compact
  end

  def validate_token(token)
    secure_token.present? && secure_token == token
  end
end
