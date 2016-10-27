admin = CreateAdminService.create_admin
puts 'CREATED ADMIN USER: ' << admin.email

# Add an LTI Application
lti_applications = [{
  name: "LTI Starter App",
  lti_key: "lti-starter-app",
  description: "LTI Starter App by Atomic Jolt",
  client_application_name: "app",
  lti_consumer_uri: "https://atomicjolt.instructure.com",
  canvas_api_permissions: "LIST_ACCOUNTS" # List Canvas API methods the app is allowed to use. A full list of constants can be found in canvas_urls
}]

lti_applications.each do |attrs|
  if lti_application = LtiApplication.find_by(lti_key: attrs[:lti_key])
    lti_application.update_attributes!(attrs)
  else
    LtiApplication.create!(attrs)
  end
end

Lti::Utils.lti_configs