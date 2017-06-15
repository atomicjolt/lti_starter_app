# Change Log

## 1.0.0
Channels all OAuth requests through a single domain. The applications root domain will be used in combination with
the value defined by "oauth_subdomain" in secrets.yml. i.e. <oauth_subdomain>.<application_root_domain>