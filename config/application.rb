require_relative "boot"
require_relative "../app/lib/oauth_state_middleware"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LtiStarterApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    #
    ### Custom
    #

    config.autoload_paths << "#{config.root}/lib"

    config.action_dispatch.default_headers.delete("X-Frame-Options")

    # Middleware that can restore state after an OAuth request
    config.middleware.insert_before 0, OauthStateMiddleware

    ActiveRecord::Tasks::DatabaseTasks.structure_dump_flags = ['--clean', '--if-exists']
    config.active_record.schema_format = :sql
    config.active_record.dump_schemas = "public"
    config.active_job.queue_adapter = :que

    # Store a reference to the encryption key in the encrypted message itself.
    config.active_record.encryption.store_key_references = true

    config.webpack = {
      use_manifest: false,
      asset_manifest: {},
      common_manifest: {},
    }
  end
end
