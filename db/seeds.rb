admin = CreateAdminService.new.call
puts "CREATED ADMIN USER: " << admin.email

secrets = Rails.application.secrets

# Add sites
sites = [
  {
    url: secrets.canvas_url,
    oauth_key: secrets.canvas_developer_id,
    oauth_secret: secrets.canvas_developer_key,
  },
  {
    url: "https://lti-ri.imsglobal.org",
  },
  {
    url: "https://dev1.sakaicloud.com",
  },
]

# Each API endpoint must include a list of LTI and internal roles that are allowed to call the endpoint.
# A list of possible roles is available in the IMS LTI specification:
# https://www.imsglobal.org/specs/ltiv1p1p1/implementation-guide#toc-41
# If an endpoint does not list a role then the roles listed under "default" will be used.
# Roles included in "common" will be merged into each API endpoint's roles.
#
# Examples roles from Canvas LTI launch
# urn:lti:instrole:ims/lis/Administrator, Institution Role
# urn:lti:instrole:ims/lis/Instructor,    Institution Role
# urn:lti:instrole:ims/lis/Student,       Institution Role
# urn:lti:role:ims/lis/Instructor,        Context Role
# urn:lti:role:ims/lis/Learner,           Context Role
# urn:lti:sysrole:ims/lis/User            System Role

admin_api_permissions = {
  default: [
    "administrator", # Internal (non-LTI) role
    "urn:lti:sysrole:ims/lis/SysAdmin",
    "urn:lti:sysrole:ims/lis/Administrator",
  ],
  common: [],
  LIST_ACTIVE_COURSES_IN_ACCOUNT: [],
  LIST_EXTERNAL_TOOLS_COURSES: [],
  CREATE_EXTERNAL_TOOL_COURSES: [],
  DELETE_EXTERNAL_TOOL_COURSES: [],
  LIST_EXTERNAL_TOOLS_ACCOUNTS: [],
  CREATE_EXTERNAL_TOOL_ACCOUNTS: [],
  DELETE_EXTERNAL_TOOL_ACCOUNTS: [],
  HELPER_ALL_ACCOUNTS: [],
}

bundles = [
  {
    name: "Hello World",
    key: Application::HELLOWORLD,
    applications: [Application::HELLOWORLD],
    shared_tenant: true,
  },
]

# Add an LTI Application
applications = [
  {
    key: Application::ADMIN,
    name: "LTI Admin",
    description: "LTI tool administration",
    client_application_name: "admin_app",
    canvas_api_permissions: admin_api_permissions,
    kind: Application.kinds[:admin],
    default_config: {},
    application_instances: [{
      lti_key: Application::ADMIN,
      lti_secret: Rails.env.production? ? nil : secrets.admin_lti_secret,
      site_url: secrets.canvas_url,
      domain: "#{Application::ADMIN}.#{Rails.application.secrets.application_root_domain}",
    }],
  },
  {
    key: Application::HELLOWORLD,
    name: "LTI Starter App",
    description: "LTI Starter App by Atomic Jolt.",
    client_application_name: "hello_world",
    # List Canvas API methods the app is allowed to use. A full list of constants can be found in canvas_urls
    canvas_api_permissions: {
      default: [],
      common: [],
      LIST_ACCOUNTS: [
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:role:ims/lis/Instructor",
      ],
      LIST_YOUR_COURSES: [
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:role:ims/lis/Instructor",
        "urn:lti:role:ims/lis/Learner",
      ],
    },
    default_config: {},
    lti_config: {
      title: "LTI Starter App",
      description: "The Atomic Jolt LTI Starter app",
      privacy_level: "public",
      icon: "oauth_icon.png",
      custom_fields: {
        canvas_course_id: "$Canvas.course.id",
        canvas_api_domain: "$Canvas.api.domain",
      },
      course_navigation: {
        text: "LTI Starter App",
        visibility: "public",
      },
      editor_button: {
        text: "LTI Starter App",
        visibility: "admins",
        icon_url: "atomicjolt.png",
      },
      assignment_selection: {
        text: "LTI Starter App",
      },
      link_selection: {
        text: "LTI Starter App",
      },
      content_migration: true,
    },
    application_instances: [
      {
        # Canvas
        lti_secret: Rails.env.production? ? nil : secrets.hello_world_lti_secret,
        site_url: secrets.canvas_url,
        # This is only required if the app needs API access and doesn't want each user to do the oauth dance
        canvas_token: secrets.canvas_token,
        client_id: "43460000000000180",
        deployment_id: "12400:a8a76fb8fbcc2d09787dafd28564e2ecdab51f11",
        lti_jwks_url: LtiAdvantage::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL,
        lti_token_url: LtiAdvantage::Definitions::CANVAS_AUTH_TOKEN_URL,
      },
      {
        # Sakai
        lti_secret: Rails.env.production? ? nil : secrets.hello_world_lti_secret,
        site_url: "https://dev1.sakaicloud.com",
        client_id: "188e0350-bb5d-4009-95ec-5e4423f0822e",
        deployment_id: "1",
        lti_jwks_url: "https://dev1.sakaicloud.com/imsblis/lti13/keyset/18",
        lti_token_url: "https://dev1.sakaicloud.com/imsblis/lti13/token/18",
      },
      {
        #IMS Global Reference application
        lti_secret: Rails.env.production? ? nil : secrets.hello_world_lti_secret,
        site_url: "https://lti-ri.imsglobal.org",
        client_id: "ims-client-1000",
        deployment_id: "deployment1",
        lti_jwks_url: "https://lti-ri.imsglobal.org/platforms/275/platform_keys/269.json",
        lti_token_url: "https://lti-ri.imsglobal.org/platforms/275/access_tokens",
      }
    ],
  }
]

def setup_application_instances(application, application_instances)
  puts "*** Seeding Application Instances ***"
  application_instances.each do |attrs|
    site = Site.find_by(url: attrs.delete(:site_url))
    attrs = attrs.merge(site_id: site.id)
    share_instance = attrs.delete(:share_instance)

    app_inst = application.application_instances.new(attrs)
    if application_instance = application.application_instances.find_by(lti_key: app_inst.key)
      puts "Updating application instance with lti key: #{application_instance.lti_key} for site: #{site.url}"
      # Don't change production lti keys and canvas_token or set keys to nil
      if attrs[:lti_secret].blank?
        attrs.delete(:lti_secret)
        puts "- lti_secret is blank. Not updating value."
      end
      if attrs[:lti_key].blank?
        attrs.delete(:lti_key)
        puts "- lti_key is blank. Not updating value."
      end
      if attrs[:canvas_token].blank?
        attrs.delete(:canvas_token)
        puts "- canvas_token is blank. Not updating value."
      end

      application_instance.update_attributes!(attrs)
    else
      puts "Creating new application instance for site: #{site.url}"
      application_instance = application.application_instances.create!(attrs)
    end

    # Check to see if the application instance needs to share a tenant with another
    # application instance. To use this include a value on the application instance
    # called "share_instance" and set it to the application key related to the
    # application instance it should share tenants with.
    if share_instance
      application_instance.tenant = application_instance.key(share_instance)
      application_instance.save!
    end
  end
end

if Apartment::Tenant.current == "public"
  puts "*** Seeding Sites ***"
  sites.each do |attrs|
    if site = Site.find_by(url: attrs[:url])
      puts "Updating site: #{site.url}"
      attrs.delete(:oauth_key) if attrs[:oauth_key].blank?
      attrs.delete(:oauth_secret) if attrs[:oauth_secret].blank?
      site.update_attributes!(attrs)
    else
      puts "Creating site: #{attrs[:url]}"
      Site.create!(attrs)
    end
  end

  puts "*** Seeding Applications ***"
  applications.each do |attrs|
    application_instances = attrs.delete(:application_instances)
    if application = Application.find_by(key: attrs[:key])
      puts "Updating application: #{application.name}"
      application.update_attributes!(attrs)
    else
      puts "Creating application: #{attrs[:name]}"
      application = Application.create!(attrs)
    end
    setup_application_instances(application, application_instances)
  end

  bundles.each do |attrs|
    current_bundle = Bundle.find_or_create_by(key: attrs[:key])
    current_bundle.update!(name: attrs[:name], shared_tenant: attrs[:shared_tenant] == true)

    attrs[:applications].reduce(current_bundle) do |bundle, key|
      app = Application.find_by!(key: key)
      bundle.application_bundles.find_or_create_by(bundle_id: bundle.id, application_id: app.id)
      bundle
    end
  end

  ApplicationInstance.where(bundle_instance_id: nil).find_each do |instance|
    bundle = Bundle.includes(:applications).by_application_id(instance.application.id).last
    BundleInstance.create(site: instance.site, bundle: bundle)
  end

  BundleInstance.find_each do |bundle_instance|
    site = bundle_instance.site
    bundle_instance.applications.each do |app|
      if instance = app.application_instances.find_by(site: site)
        instance.update(bundle_instance: bundle_instance) if instance.bundle_instance_id.nil?
      end
    end
  end

  begin
    Apartment::Tenant.create Application::AUTH
  rescue Apartment::TenantExists
    # Do nothing if the tenant already exists
  end
end

## Use this to update all the application instances
ApplicationInstance.for_tenant(Apartment::Tenant.current).find_each do |ai|
  Jwk.create!
end
