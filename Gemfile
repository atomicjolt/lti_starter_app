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
gem "rails", "6.1.3.1"

# Improve boot time
gem "bootsnap", require: false

# Database
gem "composite_primary_keys", git: "https://github.com/composite-primary-keys/composite_primary_keys.git" # unreleased rails 6.1 support
gem "pg"
gem "ros-apartment", require: "apartment"

# authentication, authorization, integrations
gem "attr_encrypted"
gem "cancancan"
gem "devise"
gem "devise_invitable"
gem "strong_password"
gem "ims-lti", "~> 2.1.5" # IMS LTI tool consumers and providers
gem "json-jwt"
gem "jwt"
gem "lms-api", "~>1.12.0"
gem "lms-graphql-api", ">=0.5.3"
gem "omniauth"
gem "omniauth-canvas", "~>1.0.2"
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

# Used for deploying to Heroku. Can be removed if not deploying to Heroku.
gem "heroku_secrets", git: "https://github.com/alexpeattie/heroku_secrets.git"

# API Related
gem "httparty"
gem "rack-cors", require: "rack/cors"

# Paging
gem "will_paginate"

# Javascript
gem "webpacker"

# Application secrets checker
gem "nuclear_secrets"

# This is only here because we are on ruby 2.4. When we upgrade ruby we can remove this
gem "sprockets", "~>3.7.2"

gem "graphql", "~>1.9.18" # TODO 1.10.x breaks the app. Need to figure out why
gem "graphql-batch", "~> 0.3.9"
gem "graphql-guard"

group :development do
  # UI
  gem "autoprefixer-rails"
  gem "non-stupid-digest-assets" # also compile assets without digest (fixes font problem)
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
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen"
  gem "web-console", "~>3.7.0"
end

group :development, :linter do
  gem "rubocop", "~> 0.88.0"
  gem "rubocop-performance", "~> 1.7.1"
  gem "rubocop-rails", "~> 2.7.1"
end

group :development, :build, :ci, :test do
  # Assets
  gem "sassc-rails"
end

group :ci do
  gem "pronto"
  gem "pronto-eslint", require: false
  gem "pronto-rubocop", require: false
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "debase"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "guard-rspec", require: false
  gem "rails-controller-testing"
  gem "rspec-rails"
  gem "ruby-debug-ide"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "webmock"
end

group :production do
  gem "rails_12factor"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
