# Allow requests from subdomains like 'www.yourcustomdomain.com'
# and 'blog.yourcustomdomain.com'.
Rails.application.config.hosts << ".#{Rails.application.secrets.application_root_domain}"
