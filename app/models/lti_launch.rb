class LtiLaunch < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer
  belongs_to :lti_context, optional: true
  belongs_to :lti_deployment, optional: true
  belongs_to :parent, optional: true, class_name: :LtiLaunch
end
