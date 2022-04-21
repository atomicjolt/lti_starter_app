# Change Log

## 2.0.0
The LTI Starter App has been updated with all the latest Node packages and Rails gems.
* Unused NPM packages have been removed. If those packages are used in other apps they will need to be re-added
* testEnvironment has been set to jsdom
* Rails 7 won't allow redirects to 3rd party urls without "allow_other_host" e.g. redirect_to(url, allow_other_host: true)

### attr_encrypted is no longer supported. Use the built in Rails 7 encryption instead
NOTE: Check the application to see if it contains any additional encrypted columns. The changes to
the starter app only include the following columns:

ApplicationInstance
  :canvas_token

Authentication
  :token
  :secret
  :refresh_token


Run:
 `bin/rails db:encryption:init`

The output will look something like this:
  `active_record_encryption:
    primary_key: yTryrXorizxpbYKI7KG0ILAe9I4Xal7z
    deterministic_key: e26W58jyLcRB87a0xzmVG0FvzO8qt6ek
    key_derivation_salt: pyXxTteJsLcjD3XHblPlEOgBdq82pgxN
  `
Add the output to the Rails credentials files using edit:
 `rails credentials:edit --environment=development`
** Be sure to set the value in development, test, and production

After running migrations run the following rake task to migrate the encrypted data:
`bundle exec rake migrate:encrypted_up`

The data can also be rolled back if needed:
`bundle exec rake migrate:encrypted_down`

After the data has been migrated the following migration can be added to remove the old columns
`class RemoveAttrEncryptedColumns < ActiveRecord::Migration[7.0]
  def up
    # ApplicationInstance
    remove_column :application_instances, :encrypted_canvas_token_2
    remove_column :application_instances, :encrypted_canvas_token_2_iv
    remove_column :application_instances, :encrypted_canvas_token_2_salt

    # Authentication
    remove_column :authentications, :encrypted_token_2
    remove_column :authentications, :encrypted_token_2_iv
    remove_column :authentications, :encrypted_token_2_salt

    remove_column :authentications, :encrypted_secret_2
    remove_column :authentications, :encrypted_secret_2_iv
    remove_column :authentications, :encrypted_secret_2_salt

    remove_column :authentications, :encrypted_refresh_token_2
    remove_column :authentications, :encrypted_refresh_token_2_iv
    remove_column :authentications, :encrypted_refresh_token_2_salt
  end

  def down
    # ApplicationInstance
    add_column :application_instances, :encrypted_canvas_token_2, :string
    add_column :application_instances, :encrypted_canvas_token_2_iv, :string
    add_column :application_instances, :encrypted_canvas_token_2_salt, :string

    # Authentication
    add_column :application_instances, :encrypted_token_2, :string
    add_column :application_instances, :encrypted_token_2_iv, :string
    add_column :application_instances, :encrypted_token_2_salt, :string

    add_column :application_instances, :encrypted_secret_2, :string
    add_column :application_instances, :encrypted_secret_2_iv, :string
    add_column :application_instances, :encrypted_secret_2_salt, :string

    add_column :application_instances, :encrypted_refresh_token_2, :string
    add_column :application_instances, :encrypted_refresh_token_2_iv, :string
    add_column :application_instances, :encrypted_refresh_token_2_salt, :string
  end
end`

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