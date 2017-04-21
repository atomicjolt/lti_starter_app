admin = CreateAdminService.new.call
puts "CREATED ADMIN USER: " << admin.email
admin.save!

# Add sites
sites = [
  {
    url: Rails.application.secrets.canvas_url,
    oauth_key: Rails.application.secrets.canvas_developer_id,
    oauth_secret: Rails.application.secrets.canvas_developer_key,
  },
]

admin_api_permissions = %w(
  LIST_ACTIVE_COURSES_IN_ACCOUNT
  LIST_EXTERNAL_TOOLS_COURSES
  CREATE_EXTERNAL_TOOL_COURSES
  DELETE_EXTERNAL_TOOL_COURSES
  LIST_EXTERNAL_TOOLS_ACCOUNTS
  CREATE_EXTERNAL_TOOL_ACCOUNTS
  DELETE_EXTERNAL_TOOL_ACCOUNTS
  GET_SUB_ACCOUNTS_OF_ACCOUNT
  HELPER_ALL_ACCOUNTS
).join(",")

# Add an LTI Application
applications = [
  {
    name: "LTI Admin",
    description: "LTI tool administration",
    client_application_name: "admin_app",
    canvas_api_permissions: admin_api_permissions,
    kind: Application.kinds[:admin],
    default_config: { foo: "bar" },
    application_instances: [{
      tenant: Rails.application.secrets.admin_lti_key,
      lti_key: Rails.application.secrets.admin_lti_key,
      lti_secret: Rails.application.secrets.admin_lti_secret,
      site_url: Rails.application.secrets.canvas_url,
      domain: "#{Rails.application.secrets.admin_subdomain}.#{Rails.application.secrets.application_root_domain}",
    }],
  },
  {
    name: "LTI Starter App",
    description: "LTI Starter App by Atomic Jolt",
    client_application_name: "hello_world",
    # List Canvas API methods the app is allowed to use. A full list of constants can be found in canvas_urls
    canvas_api_permissions: "LIST_ACCOUNTS",
    default_config: { foo: "bar" },
    lti_config: {
      title: "LTI Starter App",
      visibility: "public",
      icon: "oauth_icon.png",
      course_navigation: {
        text: "LTI Starter App",
        visibility: "public",
      },
    },
    application_instances: [{
      tenant: Rails.application.secrets.hello_world_lti_key,
      lti_key: Rails.application.secrets.hello_world_lti_key,
      lti_secret: Rails.application.secrets.hello_world_lti_secret,
      site_url: Rails.application.secrets.canvas_url,
      # This is only required if the app needs API access and doesn't want each user to do the oauth dance
      canvas_token: Rails.application.secrets.canvas_token,
      # Each application instance can have it's own custom domain. Typically, this is not needed
      # as the application will use the oauth_consumer_key from the LTI launch to partition different
      # application instances. However, if Canvas is launching the LTI tool based on url then you will
      # need a different domain for that tool since Canvas uses the domain to find the LTI tool among
      # all installed LTI tools. If two tools share the same domain then the tool discovered by Canvas
      # to do the LTI launch will be indeterminate
      domain: "#{Rails.application.secrets.hello_world_lti_key}.#{Rails.application.secrets.application_root_domain}",
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
