class ApplicationInstance < ActiveRecord::Base

  serialize :config, HashSerializer
  serialize :lti_config, HashSerializer

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

  def lti_config_xml
    domain = self.domain || Rails.application.secrets.application_main_domain
    config = lti_config.dup
    if config.present?
      config[:launch_url] ||= "https://#{domain}/lti_launches"
      config[:secure_launch_url] ||= "https://#{domain}/lti_launches"
      config[:domain] ||= domain
      config[:icon] ||= "https://#{domain}/#{config[:icon]}"
      Lti::Config.xml(config)
    end
  end

  private

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
    self.lti_config = application.lti_config if lti_config.blank?
  end

  # Danger! Whole databases will be lost with this method!
  def destroy_schema
    Apartment::Tenant.drop tenant
  end
  private :destroy_schema

end
