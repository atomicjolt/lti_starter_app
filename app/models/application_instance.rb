class ApplicationInstance < ActiveRecord::Base
  include LtiModelSupport

  serialize :config, HashSerializer

  belongs_to :application, counter_cache: true
  belongs_to :site

  validates :lti_key, presence: true, uniqueness: true
  validates :lti_secret, presence: true
  validates :site_id, presence: true

  before_validation :set_lti
  before_validation on: [:update] do
    errors.add(:lti_key, "cannot be changed after creation") if lti_key_changed?
  end

  # example store_accessor for config
  # This allows access to instance.config[:foo] like instance.foo
  # Or instance.bar
  # If foo is not set in the config json, it will return nil
  # store_accessor :config, :foo, :bar

  attr_encrypted :canvas_token, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt

  after_commit :create_schema, on: :create
  before_create :create_config
  before_create :set_lti_config

  def lti_config_xml
    Lti::Utils.lti_config_xml(self)
  end

  private

  def set_lti_config
    self.visibility = application.visibility
    self.lti_type = application.lti_type
  end

  def set_lti
    self.lti_key = (lti_key || application.name)&.parameterize&.dasherize
    self.lti_secret = ::SecureRandom::hex(64) if lti_secret.blank?
    self.tenant ||= lti_key
  end

  def create_schema
    Apartment::Tenant.create tenant
  rescue Apartment::TenantExists
    # If the tenant already exists, then ignore the exception.
    # Just rescue and do nothing.
  end

  def create_config
    self.config = application.default_config if config.blank?
  end

  # Danger! Whole databases will be lost with this method!
  def destroy_schema
    Apartment::Tenant.drop tenant
  end
  private :destroy_schema

end
