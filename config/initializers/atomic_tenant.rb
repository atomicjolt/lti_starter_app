AtomicTenant.jwt_secret = Rails.application.secrets.auth0_client_secret
AtomicTenant.jwt_aud = Rails.application.secrets.auth0_client_id
AtomicTenant.admin_subdomain = "admin".freeze
