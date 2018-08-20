# Change Log

## 1.0.3
* Refactored Canvas API support from controller concern into a class
* Updates gem versions

## 1.0.2
* Adds the concept of a key for both an application and application instance. This means applications can be uniquely identified and application instances are able to automatically generate a domain based on their relationship with a site and application.

## 1.0.1
* Adds ability to do OAuth with a site id as well as a oauth_consumer_key

## 1.0.0
* Channels all OAuth requests through a single domain. The applications root domain will be used in combination with the value defined by "oauth_subdomain" in secrets.yml. i.e. <oauth_subdomain>.<application_root_domain>