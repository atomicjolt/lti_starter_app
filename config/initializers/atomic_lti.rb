AtomicLti.oidc_init_path = "/oidc/init"
AtomicLti.oidc_redirect_path = "/oidc/redirect"
AtomicLti.target_link_path_prefixes = ["/lti_launches"]
AtomicLti.default_deep_link_path = "/lti_launches"
AtomicLti.jwt_secret = Rails.application.secrets.auth0_client_secret
AtomicLti.scopes = AtomicLti::Definitions.scopes.join(" ")
