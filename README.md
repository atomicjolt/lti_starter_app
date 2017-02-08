# LTI Starter App [![Build Status](https://travis-ci.org/atomicjolt/lti_starter_app.svg?branch=master)](https://travis-ci.org/atomicjolt/lti_starter_app) [![Coverage Status](https://coveralls.io/repos/github/atomicjolt/lti_starter_app/badge.svg?branch=master)](https://coveralls.io/github/atomicjolt/lti_starter_app?branch=master)
-----------------------
There are many starter kits that will help you get started with React and Redux.
This is the one created by, maintained by and used by [Atomic Jolt](http://www.atomicjolt.com).
Atomic Jolt uses this as application as a starting place for Ruby on Rails applications that
utilize React.


## Build a new application using the LTI Starter App Rails application template:
-----------
`rails new my_app -m https://raw.githubusercontent.com/atomicjolt/lti_starter_app/master/template.rb`

## Running LTI Starter App
-----------
See [Setting up React Rails Starter App](#setup) below to configuration the application.
Once setup Start Rails and the webpack server:

```
  rails server
  yarn hot
```

## <a name="setup"></a>Setting up LTI Starter App
-----------

### File Modifications
-----------

#### Setup .env
-----------
Rename `.env.example` to `.env` and configure it to your liking.

Note: the App and Assets subdomains must be different.

#### Modify application name
1. Open application.rb and change `ltistarterapp` to the name you choose.
2. Do a global search and replace for `lti_starter_app` and change it to the
name you choose.
3. Do a global search and replace for `ltistarterapp` (use only letters or
numbers for this name. Special characters like '_' will result in errors).

### Setup script
Run the setup script to configure your local nginx and to setup symlinks to your
configuration files (database.yml, etc)

```
$ ./bin/setup
```

## Canvas API
-----------
The LTI Starter app makes working with the Canvas API simple. See
[Canvas](Canvas.md) for more information. Note that working with the Canvas API
will require a server side proxy that is not part of this project.

#### Secrets file
-----------
Rename `config/secrets.example.yml` to `config/secrets.yml`. Open the file and change each entry to values that are relevant for your application.

*This file should not be committed to your repository.*

You will need to [obtain a Developer ID and Key from an Account Admin for the
instance of Canvas the tool will be installed in](#canvas_developer_key).

You will also need to setup a default lti application and lti application
instance. See the [seeds](#seeds) section below for information on setting
up the default account.

### Project Dependencies
-----------

#### Requirements
-----------
This application requires:

-   Ruby
-   Rails
-   PostGreSQL
-   npm
-   yarn

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

### <a name="seeds"></a>Setting up Database
-----------
Setup an admin user with:
```
$ rake db:setup
```

### <a name="developer_key"></a>Setting up OAuth
-----------
**Oauth2 Redirect URI:**
https://reactrailsstarterapp.atomicjolt.xyz/auth/[provider]/callback

**Icon URL:**
https://reactrailsstarterapp.atomicjolt.xyz/oauth_icon.png

Once your request is approved you will receive a Key and Secret. Add these credentials to `config/secrets.yml` and
then add those values to devise.rb. It will look something like this:

config.omniauth :github, Rails.application.secrets.github_developer_id, Rails.application.secrets.github_developer_key, scope: 'user,public_repo'

## Development
-----------

### Client
-----------

#### Webpack
-----------
Webpack is used to build the client side application. Configure the client application in client/config/settings.js

#### React
-----------
The React Rails Starter App uses React. All client side code can be found in the "client" directory.
This project contains the code required to launch a React application. index.html.erb contains the following
code which will launch a React application whose entry point is 'app.jsx'

```
<% content_for :head do -%>
  <%= webpack_styles_tag 'styles' %>
<% end -%>

<%= render 'shared/default_client_settings' %>
<%= webpack_manifest_script %>
<div id="main-app"></div>
<%= webpack_bundle_tag 'app' %>
```

#### Assets
-----------
Any files added to the assets directory can be used by in code and assigned to a variable. This
allows for referring to assets using dynamically generated strings. The assets will be built according to
the rules specified in your webpack configuration. Typically, this means that in production the names will
be changed to include a SHA.

First importing the assets:
  `import assets from '../libs/assets';`

Then assign the assest to a variable:
  `const img = assets("./images/atomicjolt.jpg");`

The value can then be used when rendering:
  `render(){
    const img = assets("./images/atomicjolt.jpg");
    return<div>
    <img src={img} />
    </div>;
  }`

#### Static
-----------
Files added to the static directory will be copied directly into the build. These files will not be renamed.


#### Tests
-----------
Karma and Jasmine are used for testing. To run tests run:


  `yarn test`


## Deployment
-----------

### Heroku
-----------

Make sure you have signed up for a heroku account [Heroku](http://www.heroku.com). Then follow the instructions provided by Heroku to create your application.

Push secrets to production:
```
$ rake heroku:secrets RAILS_ENV=production
```

Deploy to Heroku:
```
$ git push heroku master
```

### Other Services
-----------
By default `config/unicorn.rb` is setup to deploy to Heroku. Open that file, comment out the Heroku section and uncomment the other configuration to setup unicorn for deployment to another service like AWS.

## Examples

Atomic Jolt has built a number of applications based on this source.

### Demo Arigato

This project was created for the Sales team at Instructure. It makes it simple to populate a sample Canvas course using values from Google Drive Spreadsheets.

Source Code: [https://github.com/atomicjolt/demo_arigato](https://github.com/atomicjolt/demo_arigato)


## Database
-----------
This application uses PostgreSQL with ActiveRecord.


## Tests
-----------
You may need to install chromedriver if you haven't already.

```
$ brew install chromedriver
```

To run tests:

```
$ rake spec
```

## TODO

If an admin changes the developer key and secret then existing authentications are invalid.
This will result in a 500 error. You will see the following in the log:
LMS::Canvas::InvalidRequestException (Status: 400 Error:  ....

To fix this remove all entries in the Authentications table. In the future we should detect an
invalid api token and then remove the db record forcing a new OAuth dance.



