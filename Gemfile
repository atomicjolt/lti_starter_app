# If bundler starts to act up run these commands to start over and clean up:
# rm -rf ~/.bundle/ ~/.gem/; rm -rf $GEM_HOME/bundler/ $GEM_HOME/cache/bundler/; rm -rf .bundle/; rm -rf vendor/cache/; rm -rf Gemfile.lock
# rvm gemset empty ltistarterapp
# bundle install

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 7.0.3"

gem "atomic_lti", "1.5.5"
gem "atomic_lti_1v1", "1.1.0"
gem 'atomic_tenant', "1.2.0"
gem 'atomic_admin', "0.1.0"

# gem "atomic_lti", path: "../atomic_lti"
# gem "atomic_lti_1v1", path: "../atomic_lti_1v1"
# gem "atomic_tenant", path: "../atomic_tenant"
# gem "atomic_admin", path: "../atomic_admin"

gem "propshaft"

# Improve boot time
gem "bootsnap", require: false

# Database
gem "composite_primary_keys"
gem "pg"
gem "ros-apartment", require: "apartment"

# authentication, authorization, integrations
gem "attr_encrypted", github: "PagerTree/attr_encrypted", branch: "rails-7-0-support"
gem "cancancan"
gem "devise"
gem "devise_invitable"
gem "devise-two-factor" # TOTP for devise
gem "rqrcode", "~> 2.1" # Generate QR codes for TOTP
gem "strong_password"
gem "ims-lti", "~> 2.3.3" # IMS LTI tool consumers and providers
gem "json-jwt"
gem "jwt"
gem "lms-api", "~>1.23.0"
gem "lms-graphql-api", "~>2.0.0"
gem "omniauth"
gem "omniauth-canvas"
gem "rolify"

# Email
gem "sendgrid"

# JSON parser
gem "yajl-ruby", require: "yajl"

# server
gem "puma"

# Job worker
gem "apartment-activejob-que"
gem "que"

# Errors
gem "rollbar"

# API Related
gem "httparty"

# Paging
gem "will_paginate"

# Javascript
gem "jsbundling-rails"

gem "graphql", "~>1.13.0"
gem "graphql-batch", "~>0.4.3"
gem "graphql-guard", "~>2.0.0"

group :development do
  # UI
  gem "autoprefixer-rails"
  gem "uglifier"

  gem "better_errors"
  gem "binding_of_caller", platforms: [:mri_21]
  gem "hub", require: nil
  gem "mail_view"
  gem "rails_apps_pages"
  gem "rails_apps_testing"
  gem "rails_layout"
  gem "rb-fchange", require: false
  gem "rb-fsevent", require: false
  gem "rb-inotify", require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem "listen"
  gem "web-console"
end

group :ci do
  gem "pronto"
  gem "pronto-eslint", require: false
  gem "pronto-rubocop", require: false
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "guard-rspec", require: false
  gem "rails-controller-testing"
  gem "rspec-rails"
end

group :development, :test, :linter do
  gem "brakeman"
  gem "reek"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
