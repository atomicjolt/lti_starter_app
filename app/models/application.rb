class Application < ApplicationRecord

  serialize :default_config, HashSerializer
  serialize :lti_config, HashSerializer
  serialize :lti_advantage_config, HashSerializer
  serialize :canvas_api_permissions, HashSerializer

  has_many :application_instances
  validates :name, presence: true, uniqueness: true
  validates :key, presence: true, uniqueness: true

  has_many :application_bundles
  has_many :bundles, through: :application_bundles
  has_many :jwks
  has_many :lti_installs

  after_create :generate_jwk

  # example store_accessor for default_config
  # This allows access to instance.default_config[:foo] like instance.foo
  # Or instance.bar
  # If foo is not set in the default_config json, it will return nil
  # store_accessor :default_config, :foo, :bar

  # Kinds of Applications
  # lti: LTI tools. It's possible that these are also stand alone apps that
  #                 can be used outside of an LTI launch
  # admin: The admin tool
  # app: Stand alone applications that don't require an lti launch
  enum kind: %i{lti admin app}

  ADMIN = "admin".freeze
  AUTH = "auth".freeze
  HELLOWORLD = "helloworld".freeze

  def create_instance(site: nil, bundle_instance: nil, tenant: nil, lti_key: nil)
    application_instance = application_instances.find_or_create_by(
      site: site,
      bundle_instance: bundle_instance,
      lti_key: lti_key,
    )
    if tenant.present?
      application_instance.update!(tenant: tenant)
    end
    application_instance
  end

  def lti_advantage_config_json
    domain = "#{key}.#{Rails.application.secrets.application_root_domain}"
    config = lti_advantage_config
    config[:public_jwk] = current_jwk.to_json
    config.to_json.gsub("{domain}", domain)
  end

  def current_jwk
    jwks.last || generate_jwk
  end

  def generate_jwk
    jwks.create!
  end

  def oidc_url(iss, client_id)
    lti_install_for(iss, client_id).oidc_url
  end

  def token_url(iss, client_id)
    lti_install_for(iss, client_id).token_url
  end

  def jwks_url(iss, client_id)
    lti_install_for(iss, client_id).jwks_url
  end

  def lti_install_for(iss, client_id)
    if lti_install = lti_installs.find_by(iss: iss, client_id: client_id)
      lti_install
    else
      raise LtiAdvantage::Exceptions::ConfigurationError,
            "Unable to matching LTI install for application #{name} and iss: #{iss}. Check the lti_installs table to make sure there's an entry."
    end
  end

  def self.admin
    Application.find_by(key: ADMIN)
  end
end
