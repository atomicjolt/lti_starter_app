admin = CreateAdminService.new.call
puts "CREATED ADMIN USER: " << admin.email
admin.save!

secrets = Rails.application.secrets

# Add sites
sites = [
  {
    url: secrets.canvas_url,
    oauth_key: secrets.canvas_developer_id,
    oauth_secret: secrets.canvas_developer_key,
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
  GET_SUB_ACCOUNTS_OF_ACCOUNT: [],
  HELPER_ALL_ACCOUNTS: [],
}

# Add an LTI Application
applications = [
  {
    name: "LTI Admin",
    description: "LTI tool administration",
    client_application_name: "admin_app",
    canvas_api_permissions: admin_api_permissions,
    kind: Application.kinds[:admin],
    default_config: {},
    application_instances: [{
      tenant: secrets.admin_lti_key,
      lti_key: secrets.admin_lti_key,
      lti_secret: secrets.admin_lti_secret,
      site_url: secrets.canvas_url,
      domain: "#{secrets.admin_subdomain}.#{secrets.application_root_domain}",
    }],
  },
  {
    name: "LTI Starter App",
    description: "LTI Starter App by Atomic Jolt",
    client_application_name: "hello_world",
    # List Canvas API methods the app is allowed to use. A full list of constants can be found in canvas_urls
    canvas_api_permissions: {
      default: [],
      common: [],
      LIST_ACCOUNTS: [
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Instructor",
        "urn:lti:role:ims/lis/Instructor",
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
      },
      course_navigation: {
        text: "LTI Starter App",
        visibility: "public",
      },
      editor_button: {
        text: "LTI Starter App - Content Item Select",
        visibility: "admins",
        icon: "atomicjolt.png",
      },
      assignment_selection: {
        text: "LTI Starter App - Content Item Select",
      },
      link_selection: {
        text: "LTI Starter App - Content Item Select",
      },
    },
    application_instances: [{
      tenant: secrets.hello_world_lti_key,
      lti_key: secrets.hello_world_lti_key,
      lti_secret: secrets.hello_world_lti_secret,
      site_url: secrets.canvas_url,
      # This is only required if the app needs API access and doesn't want each user to do the oauth dance
      canvas_token: secrets.canvas_token,
      # Each application instance can have it's own custom domain. Typically, this is not needed
      # as the application will use the oauth_consumer_key from the LTI launch to partition different
      # application instances. However, if Canvas is launching the LTI tool based on url then you will
      # need a different domain for that tool since Canvas uses the domain to find the LTI tool among
      # all installed LTI tools. If two tools share the same domain then the tool discovered by Canvas
      # to do the LTI launch will be indeterminate
      domain: "#{secrets.hello_world_subdomain}.#{secrets.application_root_domain}",
    }],
  },
]

def setup_application_instances(application, application_instances)
  application_instances.each do |attrs|
    site = Site.find_by(url: attrs.delete(:site_url))
    attrs = attrs.merge(site_id: site.id)

    if application_instance = application.application_instances.find_by(lti_key: attrs[:lti_key])
      # Don't change production lti keys or set keys to nil
      attrs.delete(:lti_secret) if attrs[:lti_secret].blank? || Rails.env.production?

      application_instance.update_attributes!(attrs)
    else
      application.application_instances.create!(attrs)
    end
  end
end

sites.each do |attrs|
  if site = Site.find_by(url: attrs[:url])
    site.update_attributes!(attrs)
  else
    Site.create!(attrs)
  end
end

applications.each do |attrs|
  application_instances = attrs.delete(:application_instances)
  if application = Application.find_by(name: attrs[:name])
    application.update_attributes!(attrs)
  else
    application = Application.create!(attrs)
  end
  setup_application_instances(application, application_instances)
end
