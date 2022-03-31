# Change Log

## 2.0.0
The LTI Starter App has been updated with all the latest Node packages and Rails gems.
* Unused NPM packages have been removed. If those packages are used in other apps they will need to be re-added
* testEnvironment has been set to jsdom

### Notable npm package changes that may introduce breaking changes
* Apollo has been updated to @apollo/client 3.5.10 which consolidates all Apollo code into a single library. Other Apollo packages were removed.
* graphql upgraded from 14.5.8 to 16.3.0
* jest upgraded from 24.9.0 to 27.5.1
* react-select upgraded from 3.0.4 to 5.2.2
* react-paginate upgraded from 5.2.4 to 8.1.2
* enzyme remains in the project but will be removed in a future LTI Starter app as the tests are rewritten.
* Removed packages:
  babel-preset-es2015, core-js, chart.js, classnames, react-proxy-loader, uuid

### Notable Ruby Gem changes
* que has been updated to 1.4.0
* Removed packages
  heroku_secrets, sprockets, spring, spring-commands-rspec, spring-watcher-listen, web-console, rails_12factor

## 1.0.3
* Refactored Canvas API support from controller concern into a class
* Updates gem versions

## 1.0.2
* Adds the concept of a key for both an application and application instance. This means applications can be uniquely identified and application instances are able to automatically generate a domain based on their relationship with a site and application.

## 1.0.1
* Adds ability to do OAuth with a site id as well as a oauth_consumer_key

## 1.0.0
* Channels all OAuth requests through a single domain. The applications root domain will be used in combination with the value defined by "oauth_subdomain" in secrets.yml. i.e. <oauth_subdomain>.<application_root_domain>