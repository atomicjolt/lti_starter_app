class ApplicationInstance < ActiveRecord::Base

  serialize :config, HashSerializer
  serialize :lti_config, HashSerializer

  belongs_to :application, counter_cache: true
  belongs_to :site
  belongs_to :bundle_instance

  has_many :authentications, dependent: :destroy, inverse_of: :application_instance
  has_many :lti_deployments

  validates :lti_key, presence: true, uniqueness: true
  validates :lti_secret, presence: true
  validates :site_id, presence: true
  validates :application_id, presence: true

  before_validation :set_lti
  before_validation :set_domain

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

  scope :for_tenant, ->(tenant) { where(tenant: tenant) }
  scope :by_newest, -> { order(created_at: :desc) }
  scope :by_oldest, -> { order(created_at: :asc) }
  scope :by_latest, -> { order(updated_at: :desc) }

  def self.by_client_and_deployment(client_id, deployment_id)
    LtiInstall.joins(:applications).joins(:application_instances).joins(:lti_deployments)
    if lti_install = LtiInstall.find_by(client_id: client_id)
      application_instances = lti_install.application.application_instances
        .joins(:lti_deployments)
        .where("lti_deployments.deployment_id =?", deployment_id)
      # There should only be one that matches
      application_instances.first
    end
  end

  def lti_defaults
    domain = self.domain || Rails.application.secrets.application_main_domain
    config = lti_config.dup
    if config.present?
      config[:launch_url] ||= "https://#{domain}/lti_launches"
      config[:secure_launch_url] ||= "https://#{domain}/lti_launches"
      config[:domain] ||= domain
      config[:export_url] ||= "https://#{domain}/api/ims_exports.json"
      config[:import_url] ||= "https://#{domain}/api/ims_imports.json"
      config[:icon] ||= "https://#{domain}/#{config[:icon]}"
      config[:privacy_level] = "anonymous" if anonymous?
    end
    config
  end

  def lti_advantage_config_json
    config = lti_defaults
    LtiAdvantage::Config.json(application.current_jwk, config) if config
  end

  def lti_config_xml
    config = lti_defaults
    Lti::Config.xml(config) if config
  end

  def oauth_precedence
    application.oauth_precedence.split(",")
  end

  def key(application_key_override = nil)
    return lti_key if lti_key.present?
    return "" if site.blank? || application.blank?
    "#{site.key}-#{application_key_override || application.key}"
  end

  def canvas_token_preview
    return nil if canvas_token.nil?
    "#{canvas_token.first(4)}...#{canvas_token.last(4)}"
  end

  # if you add a new value to an application's default settings, it will not
  # propogate to old app instances, this falls back to the default if it's not
  # present
  def get_config(key)
    if config.key? key
      config[key]
    else
      application.default_config[key]
    end
  end

  private

  def set_lti
    self.lti_key = lti_key || key
    self.lti_secret = ::SecureRandom::hex(64) if lti_secret.blank?
    self.tenant ||= lti_key
  end

  def set_domain
    self.domain = domain || "#{application.key}.#{Rails.application.secrets.application_root_domain}"
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
    self.anonymous = application.anonymous if anonymous.blank?
  end

  # Danger! Whole databases will be lost with this method!
  def destroy_schema
    Apartment::Tenant.drop tenant
  end
  private :destroy_schema

end
