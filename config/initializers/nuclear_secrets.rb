NuclearSecrets.configure do |config|
  config.required_secrets = {
    admin_name: String,
    admin_email: String,
    admin_password: String,
    encryption_key: String,
    application_name: String,
    application_main_domain: String,
    application_root_domain: String,
    email_provider_username: String,
    email_provider_password: String,
    assets_url: String,
    canvas_url: String,
    canvas_developer_id: Integer,
    canvas_developer_key: String,
    auth0_client_id: String,
    auth0_client_secret: String,
    hello_world_lti_secret: String,
    admin_lti_secret: String,
    secret_key_base: String,
    secret_token: NilClass,
    deploy_env: String,
  }
end
