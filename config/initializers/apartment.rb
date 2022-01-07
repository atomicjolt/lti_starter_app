# You can have Apartment route to the appropriate Tenant by adding some Rack middleware.
# Apartment can support many different "Elevators" that can take care of this routing to your data.
# Require whichever Elevator you're using below or none if you have a custom one.
#
require "apartment/elevators/generic"
# require 'apartment/elevators/domain'
# require 'apartment/elevators/subdomain'
# require 'apartment/elevators/first_subdomain'

#
# Apartment Configuration
#
Apartment.configure do |config|
  # Add any models that you do not want to be multi-tenanted, but remain in the global (public) namespace.
  # A typical example would be a Customer or Tenant model that stores each Tenant's information.
  #
  config.excluded_models = %w{
    Application
    ApplicationInstance
    OauthState
    Site
    Bundle
    BundleInstance
    ApplicationBundle
    ImsExport
    RequestStatistic
    RequestUserStatistic
    LtiDeployment
    LtiInstall
    Jwk
    OpenIdState
  }

  # In order to migrate all of your Tenants you need to provide a list of Tenant names to Apartment.
  # You can make this dynamic by providing a Proc object to be called on migrations.
  # This object should yield either:
  # - an array of strings representing each Tenant name.
  # - a hash which keys are tenant names,
  #   and values custom db config (must contain all key/values required in database.yml)
  #
  # config.tenant_names = lambda{ Customer.pluck(:tenant_name) }
  # config.tenant_names = ['tenant1', 'tenant2']
  # config.tenant_names = {
  #   'tenant1' => {
  #     adapter: 'postgresql',
  #     host: 'some_server',
  #     port: 5555,
  #     database: 'postgres' # this is not the name of the tenant's db
  #                          # but the name of the database to connect to before creating the tenant's db
  #                          # mandatory in postgresql
  #   },
  #   'tenant2' => {
  #     adapter:  'postgresql',
  #     database: 'postgres' # this is not the name of the tenant's db
  #                          # but the name of the database to connect to before creating the tenant's db
  #                          # mandatory in postgresql
  #   }
  # }
  # config.tenant_names = lambda do
  #   Tenant.all.each_with_object({}) do |tenant, hash|
  #     hash[tenant.name] = tenant.db_configuration
  #   end
  # end
  #
  config.tenant_names = lambda { ApplicationInstance.distinct.pluck(:tenant) }

  #
  # ==> PostgreSQL only options

  # Specifies whether to use PostgreSQL schemas or create a new database per Tenant.
  # The default behaviour is true.
  #
  # config.use_schemas = true

  # Apartment can be forced to use raw SQL dumps instead of schema.rb for creating new schemas.
  # Use this when you are using some extra features in PostgreSQL that can't be respresented in
  # schema.rb, like materialized views etc. (only applies with use_schemas set to true).
  # (Note: this option doesn't use db/structure.sql, it creates SQL dump by executing pg_dump)
  #
  # config.use_sql = false

  # There are cases where you might want some schemas to always be in your search_path
  # e.g when using a PostgreSQL extension like hstore.
  # Any schemas added here will be available along with your selected Tenant.
  #
  # config.persistent_schemas = %w{ hstore }

  # <== PostgreSQL only options
  #

  # By default, and only when not using PostgreSQL schemas, Apartment will prepend the environment
  # to the tenant name to ensure there is no conflict between your environments.
  # This is mainly for the benefit of your development and test environments.
  # Uncomment the line below if you want to disable this behaviour in production.
  #
  # config.prepend_environment = !Rails.env.production?
end

# Setup a custom Tenant switching middleware. The Proc should return the name of the Tenant that
# you want to switch to.
# Rails.application.config.middleware.use 'Apartment::Elevators::Generic', lambda { |request|
#   request.host.split('.').first
# }

PAYLOAD = 0
HEADER = 1

Rails.application.config.middleware.insert_before Warden::Manager, Apartment::Elevators::Generic, lambda { |request|
  if application_instance = LtiAdvantage::Authorization.application_instance_from_token(request.params["id_token"])
    return application_instance.tenant
  end

  key = Lti::Request.oauth_consumer_key(request)
  host = request.host_with_port
  subdomain = host.split(".").first

  if subdomain == Application::AUTH
    Application::AUTH
  elsif subdomain == Application::ADMIN
    Application::ADMIN
  elsif application_instance = ApplicationInstance.find_by(lti_key: key)
    application_instance.tenant
  elsif application_instance = ApplicationInstance.find_by(domain: host)
    application_instance.tenant
  elsif request.path.start_with? "/assets/" # Only affects development env
    Application::ADMIN
  elsif request.path.start_with? "/lti_dynamic_registrations" # Only affects development env
    Application::ADMIN
  else
    raise "Please specify a valid oauth_consumer_key or valid domain name for this request"
  end
}

# Rails.application.config.middleware.use 'Apartment::Elevators::Domain'
# Rails.application.config.middleware.use 'Apartment::Elevators::Subdomain'
# Rails.application.config.middleware.use 'Apartment::Elevators::FirstSubdomain'
