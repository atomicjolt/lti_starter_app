class ApplicationInstance < ApplicationRecord

  serialize :config, HashSerializer
  serialize :lti_config, HashSerializer

  belongs_to :application, counter_cache: true
  belongs_to :site
  belongs_to :bundle_instance, required: false

  has_many :authentications, dependent: :destroy, inverse_of: :application_instance
  has_many :lti_deployments, dependent: :destroy

  validates :lti_key, presence: true, uniqueness: true
  validates :lti_secret, presence: true
  validates :site_id, presence: true
  validates :application_id, presence: true

  before_validation :set_lti
  before_validation :set_domain
  before_validation :set_nickname

  before_validation on: [:update] do
    errors.add(:lti_key, "cannot be changed after creation") if lti_key_changed?
  end

  # example store_accessor for config
  # This allows access to instance.config[:foo] like instance.foo
  # Or instance.bar
  # If foo is not set in the config json, it will return nil
  # store_accessor :config, :foo, :bar
  store_accessor :config, :custom_error_message

  # NOTE these columns are temporary while we migrate away from attr_encrypted to the
  # new Rails 7 encrypt.
    attr_encrypted :canvas_token_2, key: Rails.application.secrets.encryption_key, mode: :per_attribute_iv_and_salt
  #### END
  encrypts :canvas_token

  after_commit :create_schema, on: :create
  before_create :create_config

  scope :for_tenant, ->(tenant) { where(tenant: tenant) }
  scope :by_newest, -> { order(created_at: :desc) }
  scope :by_oldest, -> { order(created_at: :asc) }
  scope :by_latest, -> { order(updated_at: :desc) }

  # Attempts to find an existing application instance that doesn't have a matching lti deployment
  def self.match_application_instance(lti_install, deployment_id)
    application_instance_ids = lti_install.lti_deployments.pluck(:application_instance_id)
    app_instance_count = application_instance_ids.uniq.count
    if app_instance_count == 0
      raise ApplicationInstanceNotFoundError, "No application instance found linked to lti_install #{lti_install.id}, client_id: #{lti_install.client_id}. Deployment_id: #{deployment_id}, will not be linked"
    elsif app_instance_count == 1
      application_instance = ApplicationInstance.find(application_instance_ids.first)
      LtiDeployment.create!(
        application_instance: application_instance,
        lti_install: lti_install,
        deployment_id: deployment_id,
      )
      application_instance
    else
      raise NonUniqueApplicationInstanceError, "Found multiple application instances: #{application_instance_ids} for #{lti_install.id}, client_id: #{lti_install.client_id}. Deployment_id: #{deployment_id} will not be linked"
    end
  end

  # Find application instance using values from the lti advantage token
  def self.by_client_and_deployment(client_id, deployment_id, iss)
    if lti_install = LtiInstall.find_by(client_id: client_id, iss: iss)
      application_instances = lti_install.application.application_instances.
        joins(:lti_deployments).
        where("lti_deployments.deployment_id =?", deployment_id)

      # There should only be one that matches
      application_instances.first ||
        match_application_instance(lti_install, deployment_id)

    end
  end

  def lti_defaults(config_options = {})
    config = lti_config.dup
    config = config.merge(config_options) unless config_options.blank?
    if config.present?
      config[:launch_url] ||= launch_url
      config[:secure_launch_url] ||= launch_url
      config[:domain] ||= get_domain
      config[:export_url] ||= "https://#{get_domain}/api/ims_exports.json"
      config[:import_url] ||= "https://#{get_domain}/api/ims_imports.json"
      config[:icon] ||= "https://#{get_domain}/#{config[:icon]}"
      config[:privacy_level] = "anonymous" if anonymous?
    end
    config
  end

  def lti_config_xml(config_options = {})
    config = lti_defaults(config_options)
    Lti::Config.xml(config) if config.present?
  end

  def get_domain
    domain || Rails.application.secrets.application_main_domain
  end

  def launch_url
    "https://#{get_domain}/lti_launches"
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

  def token_url(iss, client_id)
    url = application.token_url(iss, client_id)

    # The Canvas token endpoint is customer specific. i.e. https://atomicjolt.instructure.com
    # We can get that value from the site associated with the application instance
    if url.include?("https://canvas.instructure.com")
      url.gsub!("https://canvas.instructure.com", site.url)
    end

    if url.include?("https://canvas.beta.instructure.com")
      url.gsub!("https://canvas.beta.instructure.com", site.url)
    end

    url
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

  def oauth_key
    site.oauth_key.presence || application.oauth_key
  end

  def oauth_secret
    site.oauth_secret.presence || application.oauth_secret
  end

  def self.admin
    find_by(lti_key: Application::ADMIN)
  end

  private

  def set_lti
    self.lti_key = lti_key || key
    self.lti_secret = ::SecureRandom::hex(64) if lti_secret.blank?
    self.tenant ||= lti_key
    set_domain
  end

  def set_nickname
    if !nickname
      self.nickname = lti_key || "no nickname"
    end
  end

  def set_domain
    self.domain = domain || "#{application.key}.#{Rails.application.secrets.application_root_domain}"
  end

  # Mirroring ros-apartment lib/apartment/tasks/task_helper.rb#create_tenant
  def create_schema
    puts "Creating #{tenant} tenant"
    Apartment::Tenant.create tenant
  rescue Apartment::TenantExists => e
    puts "Tried to create already existing tenant: #{e}"
    # If the tenant already exists, then ignore the exception.
    # Just rescue and do nothing.
  end

  def create_config
    self.config = application.default_config if config.blank?
    self.lti_config = application.lti_config if lti_config.blank?
    self.anonymous = application.anonymous if anonymous.blank?
    self.rollbar_enabled = application.rollbar_enabled if rollbar_enabled.blank?
  end

  # Danger! Whole databases will be lost with this method!
  def destroy_schema
    Apartment::Tenant.drop tenant
  end
  private :destroy_schema
end

class NonUniqueApplicationInstanceError < StandardError; end
class ApplicationInstanceNotFoundError < StandardError; end
