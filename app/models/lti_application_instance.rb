class LtiApplicationInstance < ActiveRecord::Base

  belongs_to :lti_application

  validates :lti_key, presence: true
  validates :lti_key, uniqueness: true
  validates :lti_secret, presence: true
  validates :lti_consumer_uri, presence: true

  before_validation :set_lti

  enum lti_type: [:basic, :course_navigation, :account_navigation]

  attr_encrypted :canvas_token, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt

  private

    def set_lti
      self.lti_type ||= LtiApplicationInstance.lti_types[:basic]
      self.lti_key = (self.lti_key || self.lti_application.name).try(:parameterize).try(:dasherize)
      self.lti_secret = ::SecureRandom::hex(64) unless self.lti_secret.present?
    end

end
