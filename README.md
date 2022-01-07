# LTI Starter App  [![Build Status](https://travis-ci.org/atomicjolt/lti_starter_app.svg?branch=master)](https://travis-ci.org/atomicjolt/lti_starter_app) [![Coverage Status](https://coveralls.io/repos/github/atomicjolt/lti_starter_app/badge.svg?branch=master)](https://coveralls.io/github/atomicjolt/lti_starter_app?branch=master)

There are many starter kits that will help you get started with React and Redux.
This is the one created by, maintained by and used by [Atomic Jolt](http://www.atomicjolt.com).
Atomic Jolt uses this as application as a starting place for Ruby on Rails applications that
utilize React.

# Getting Started

Build a new application using the LTI Starter App Rails application template:

```
rails new my_app -m https://raw.githubusercontent.com/atomicjolt/lti_starter_app/master/template.rb
```

## Prerequisites
### This application requires the following technologies:

-   Ruby
-   Rails ([Info / Installation](http://railsapps.github.io/installing-rails.html))
-   PostGreSQL ([Info / Installation](https://wiki.postgresql.org/wiki/Detailed_installation_guides))
-   NodeJS  ([Info / Installation](https://github.com/creationix/nvm))
-   yarn ([Info / Installation](https://yarnpkg.com/lang/en/docs/install))

### Canvas Developer ID and Key
You will need to [obtain a Developer ID and Key from an Account Admin for the instance of Canvas the tool will be installed in](#obtain-a-canvas-developer-key).

### Default LTI Application
You will also need to setup a default LTLI application and LTI application instance. See the [sections below](#setting-up-lti-starter-app) for information on setting up the default account.


## Running LTI Starter App

After [setting up the LTI Starter App](#setting-up-lti-starter-app), start Rails and the webpack server:
```
  $ rails server
  $ yarn hot
```


## Setting up LTI Starter App

### File Modifications
-----------

#### Setup .env
Rename `.env.example` to `.env` and configure it to your liking.
The setup process and the application pulls environment variables from your current shell session, so you need to export your .env into your current shell using something like [autoenv](https://github.com/inishchith/autoenv) or [direnv](https://direnv.net/)

Note: the App and Assets subdomains must be different.


#### Modify application name (*Note: if you started a new rails project with this as a template, this step should already be done*)
1. Open application.rb and change `ltistarterapp` to the name you choose.
2. Do a global search and replace for `lti_starter_app` and change it to the name you choose.
3. Do a global search and replace for `ltistarterapp` (use only letters or numbers for this name. Special characters like '_' will result in errors).

#### Update webpack.yml
1. Open `config/webpack.yml`
2. Update `dev_server: { public: assets.atomicjolt.xyz }` to match the assets domain provided in the .env file

#### Setup config files with bin/setup script (optional)

#### Change `bin/bootstrap`
In `bin/bootstrap` change the following line to point to a dropbox folder containing the correct config files for the project. For example:
```
DROPBOX_FOLDER=aj-dev/lti_starter_app
```

#### Setup script
Run the setup script to configure your local nginx and to setup symlinks to your configuration files (database.yml, secrets.yml, etc).
```
$ ./bin/setup
```
Or, if you're on Linux:
```
$ ./bin/setup-linux
$ ./bin/bootstrap
```
Depending on the system, this script may require superuser privileges.


#### Secrets file
Rename `config/secrets.yml.example` to `config/secrets.yml` and rename `config/database.yml.example` to `config/database.yml`.

Note: If you ran ./bin/setup it calls to the ./bin/bootstrap script which symlinks the files located in the path that was specified as the DROPBOX_FOLDER. If the database.yml and secrets.yml are located in that location then you won't need to rename them from .yml.example.

Open the files and change each entry to values that are relevant for your application.

*These files should not be committed to your repository*


### Setting up the Database
Setup an admin user and the default LTI application with:
```
$ rake db:setup
```

If you have setup .env and the secrets.yml file then the seeds file shouldn't need to be changed. However, if you need to customize the values in the database or add additional records to the database, open `db/seeds.rb` and configure a default account for development and production. Here's a summary of the values and their purpose:

- **code:** Uniquely identifies the account. This is used for the subdomain when running
applications on a single domain. By default this will be set to APP_SUBDOMAIN from the .env file.
- **domain:** Custom domain name. By default this is set to application_main_domain from the secrets.yml file.
- **name:** Name the account anything you'd like. By default this is set to application_name from the secrets.yml file.
- **lti_key:** A unique key for the LTI application you are building. This will be provided to Canvas. By default this will be set to APP_SUBDOMAIN from the .env file.
- **lti_secret:** The shared secret for your LTI application. This will be provided to Canvas and will be used to sign the LTI request. Generate this value using `rake secret`. Alternatively if you leave this field empty an LTI secret will be automatically generated for the account.
- **canvas_uri:** The URI of the Canvas institution to be associated with a specific account.

If you run into an error while installing the pg gem try including the path to pg_config. For an example see
the command below. Be sure to use the correct version for the pg gem and the correct path to pg_config.

```
gem install pg -v '1.2.2' --source 'https://rubygems.org/' -- --with-pg-config=/path/to/pg_config
```

### Running The App

Now setup should be complete, startup the dev servers with these commands:
```
  $ rails server
  $ yarn hot
```
Now you should be able to navigate to `ltistarterapp.atomicjolt.xyz` in the browser and see a basic LTI app.
Currently the lists will be empty as it is not installed into an LMS, there are not LTI Advantage Services for it to read from

## Obtain a Canvas Developer Key
Only a Canvas Account Admin can create a developer key for your LTI Application. To create a key, go to Accounts -> Developer Keys and create a new LTI key and enter the info described below below.

Subsitute `ltistarterapp.atomicjolt.xyz` with your domain. (atomicjolt.xyz will only work for AtomicJolt employees). Also, note that `ltistarterapp` is the `APP_SUBDOMAIN` specified in the .env file.

You will need an ID and secret for development and for production. The development URI will use atomicjolt.xyz while the production URI will use your domain (e.g. ltistarterapp.herokuapp.com).

**Key Name:**
Can be anything you choose (e.g. LTI Starter App)

**Owner Email:**
Address that will receive email about technical issues related to the tool.

**Redirect URIs:**
```
https://ltistarterapp.atomicjolt.xyz/lti_launches
https://ltistarterapp.atomicjolt.xyz/users/auth/[provider]/callback
```
`provider` here refers to the LTI tool provider that the app is to be installed in (i.e Canvas or Blackboard). So if the app was being installed in canvas the url would be `https://ltistarterapp.atomicjolt.xyz/users/auth/canvas/callback`

**Title**: Can be anything you choose (e.g. LTI Starter App)

**Description**: Short description of what the key will be used for

**Target Link URI:**
```
https://ltistarterapp.atomicjolt.xyz/lti_launches
```
This will be the url used by the LMS when launching the LTI application

**OpenID Connect Initiation Url:**
```
https://ltistarterapp.atomicjolt.xyz/lti_launches/init
```

**JWK Method (Only for LTI Advantage Installs):** Public JWK

Navigate to `https://ltistarterapp.atomicjolt.xyz/jwks.json` to get a list of JWK keys that are usable for development. Normally for production you would use a *Public JWK Url* to generate the keys as needed

There are many more settings and options available to play around with when creating a key, but these are the nessecary ones when getting a basic app setup.

Some of these other options are:
- LTI Advantage Services - Various services that LTI Advantage compliant apps can utillize
- Icon settings - Image to display in relation to your app
- (Canvas) Custom Fields - Canvas can provide various extra data in an LTI launch
- Account navigation - Where navigation to your app shows up

Once you press Save Key, a Developer ID and Key will be generated and displayed in the Details column of the Developer Keys table when you mouse over the row.
Add these credentials under `CANVAS_DEVELOPER_ID` and `CANVAS_DEVELOPER_KEY` (in .env) or `canvas_developer_id` and `canvas_developer_key` (in secrets.yml). These will be used to preform the OAuth Dance with Canvas and obtain the user's auth token.

# Installing The App
Now that we've got the dev servers up and running and we've got a developer key we can go and get our app installed! This starter app supports both LTI 1.3 and LTI Advantage

## LTI 1.3
To install an LTI 1.3 application to to `Account / Course -> Settings -> Apps` and add a new app. There are serveral different ways that an app can be installed, we will be installing via XML, so select that in the Configuration Type dropdown.

Now run this command:
```
$ rake lti:configs
```
This will output the Consumer Key, Shared Secret, and XML Configuration of each LTI app in the project. Copy and paste those into the relevant fields and click the submit button. Now your app should be ready to go!

## LTI Advantage
Currenlty the only way to install an LTI advantage app (at least on Canvas) is by using the "By Client ID" Configuration type. Create a LTI Key with your required services. Copy the Client Id it provides and paste it as the value of `client_id` in `db/seeds.rb` for both the Canvas and Test Canvas instance. Seed the DB with this value.

Got to `Account / Course -> Settings -> Apps` and add a new app. Select by Client Id in the Configuration Type dropdown. Paste in the key and hit submit. Canvas should ask you if you want to install an app with the app name you provided while creating the key. If this looks write, click submit. Your LTI Advantage app should now be installed.

# Development Notes
Run a cloudflare tunnel to connect your dev machine to a remote LMS for testing.
`cloudflared tunnel --hostname hellolti.atomicjolt.xyz --url localhost:3030 --name hellolti ----overwrite-dns, -f`

List tunnels
`cloudflared tunnel list`
Dyanmic registration URL:

https://lti.atomicjolt.xyz/lti_dynamic_registrations

## Versions
We follow some conservative rules:

  1. Use what’s packaged by Debian/Ubuntu, whenever possible, except for Gems and NPM packages.
  2. For software not packaged by Debian/Ubuntu, use the oldest version that still receives security updates.
  3. Gems and NPM packages may use the newest version, as long as doing so does
  not conflict with other software adhering to the previous two rules.

## Canvas API

The LTI Starter app makes working with the Canvas API simple. See [Canvas](Canvas.md) for more information. Note that working with the Canvas API will require a server side proxy that is not part of this project.


## Admin Page

There is an admin page where one can setup the tools located at `/admin`. The Admin email and password can be found in `config/secrets.yml`. In the settings for an Application Instance, Visibility can be configured to affect who can see the tool when it gets installed.

## Development Details

### Webpack
Webpack is used to build the client side application. Configure the client application in `config/webpacker.yml`

### React
The React Rails Starter App uses React. All client side code can be found in the "client" directory. This project contains the code required to launch a React application. `app/views/lti_launches/index.html.erb` contains roughly the following code which will launch a React application whose entry point is 'app.jsx'

```erb
<% content_for :head do -%>
  <%= stylesheet_pack_tag 'styles' %>
<% end -%>

<%= render 'shared/default_client_settings' %>
<div id="main-app"></div>
<%= javascript_packs_with_chunks_tag "app", "data-turbolinks-track": "reload" %>
```

### Assets
Any files added to the assets directory can be used by in code and assigned to a variable. This allows for referring to assets using dynamically generated strings. The assets will be built according to the rules specified in your webpack configuration. Typically, this means that in production the names will be changed to include a SHA.

```js
import assets from '../libs/assets'; # First importing the assets
const img = assets("./images/atomicjolt.jpg"); # Then assign an asset to a variable
```

The value can then be used when rendering:
```js
render() {
    const img = assets("./images/atomicjolt.jpg");
    return(
      <div>
        <img src={img} />
      </div>
    );
  }
```

### Tenants
Each application instance maintains it's own database schema. The LTI starter app uses the Apartment gem and these
are called "tenants". In some instances multiple application instances need to share the same tenant. It is possible
to do this in the seeds when creating application instances. To use this include a value on the application instance
being created in the seeds.rb file called "share_instance" and set it to the application key related to the
application instance it should share tenants with.


## Scripts
The following scripts are available for testing, building and deploying applications

### **Yarn**
-----------------------

Run all tests:
  `yarn test`

Update Jest snapshots:
  `yarn test_update`

Run Jest in debug mode:
  `yarn test_debug`

Run webpack hot reload server:
  `yarn hot`

Run a linter over the project:
  `yarn lint`

Allow the linter to attempt to fix problems
  `yarn lint_fix`

Wipe out all node modules:
  `yarn nuke`

### **Rake Tasks**
-----------------------
Note: each of these tasks are ran with `rake`

List all LTI tools
  `lti:list_all`

Remove all LTI tool installs
  `lti:destroy_all`

Get basic LTI configuration for install LTI 1.3 applications:
  `lti:configs`

Remove old nonces from the DB:
  `lti:clean`


# Deployment

## Heroku

Make sure you have signed up for a heroku account [Heroku](http://www.heroku.com). Then follow the instructions provided by Heroku to create your application.

Push secrets to production:
```
$ rake heroku:secrets RAILS_ENV=production
```

Deploy to Heroku:
```
$ git push heroku master
```

## Other Services
By default `config/unicorn.rb` is setup to deploy to Heroku. Open that file, comment out the Heroku section and uncomment the other configuration to setup unicorn for deployment to another service like AWS.

## Examples

Atomic Jolt has built a number of applications based on this source.

### [Demo Arigato](https://github.com/atomicjolt/demo_arigato)
-----------
This project was created for the Sales team at Instructure. It makes it simple to populate a sample Canvas course using values from Google Drive Spreadsheets.


## Tests

You may need to install chromedriver if you haven't already.

```
$ brew install chromedriver
```

To run Ruby tests:

```
$ rake spec
```

To run Jest tests:

```
$ yarn test
```

