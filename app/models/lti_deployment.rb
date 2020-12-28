class LtiDeployment < ApplicationRecord
  belongs_to :application_instance
  belongs_to :lti_install
  belongs_to :lti_platform_instance, optional: true

  validates :application_instance_id, presence: true
  validates :deployment_id, presence: true, uniqueness: { scope: %i[application_instance_id] }

  def update_at_lti_advantage_launch(lti_token)
    platform_claim = lti_token[LtiAdvantage::Definitions::TOOL_PLATFORM_CLAIM]
    if platform_claim
      if !lti_platform_instance
        lti_platform_instance.find_or_create_by(
          guid: platform_claim["guid"],
          iss: lti_install.iss,
        )
        save
      end
      lti_platform_instance.update(platform_claim.slice("name", "product_family_code"))
    end
  end
end
