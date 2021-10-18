# Allow requests from subdomains like 'www.yourcustomdomain.com'
# and 'blog.yourcustomdomain.com'.
Rails.application.config.hosts << ".#{Rails.application.secrets.application_root_domain}"

# Rails 6 no longer allows underscores in domain names, which we still use for
# some clients. This disables the host checking, so the line above is
# essentially unused until find a better way to handle this
# https://github.com/rails/rails/issues/41545
Rails.application.config.hosts.clear
