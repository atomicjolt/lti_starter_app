admin = CreateAdminService.create_admin
puts 'CREATED ADMIN USER: ' << admin.email

# Add an LTI Application
lti_applications = [{
  name: "LTI Starter App",
  description: "LTI Starter App by Atomic Jolt",
  lti_key: "lti-starter-app",
  lti_secret: Rails.application.secrets.scorm_lti_key,
  lti_consumer_uri: "https://atomicjolt.instructure.com",
  client_application_name: "app",
  canvas_api_permissions: "LIST_ACCOUNTS", # List Canvas API methods the app is allowed to use. A full list of constants can be found in canvas_urls
  canvas_token: Rails.application.secrets.canvas_token # This is only required if the app needs API access and doesn't want each user to do the oauth dance
}]

lti_applications.each do |attrs|
  if lti_application = LtiApplication.find_by(lti_key: attrs[:lti_key])
    lti_application.update_attributes!(attrs)
  else
    LtiApplication.create!(attrs)
  end
end

Lti::Utils.lti_configs