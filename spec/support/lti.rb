# All options must be string keys. Symbols won't work. launch_url is required and should
# look like lti_params({"launch_url" => lti_launches_url})
def lti_params(oauth_consumer_key = "aconsumerkey", oauth_consumer_secret = "secret", options = {})
  raise "launch_url is a required parameter" unless options["launch_url"]
  # keys in params must be strings
  params = {
    "resource_link_id" =>                    "120988f929-274612",
    "resource_link_title" =>                 "Steve Job's biography",
    "resource_link_description" =>           "Biography of Steve Jobs",
    "user_id" =>                             "292832126",
    "roles" =>                               "Instructor",
    "lis_person_name_full" =>                "Steve Jobs",
    "lis_person_name_family" =>              "Jobs",
    "lis_person_name_given" =>               "Steve",
    "lis_person_contact_email_primary" =>    "steve@apple.com",
    "lis_person_sourced_id" =>               "school.edu:user",
    "context_id" =>                          "456434513",
    "context_title" =>                       "Great Innovators",
    "context_label" =>                       "SI182",
    "lis_outcome_service_url" =>             "http://www.imsglobal.org/developers/BLTI/tool_consumer_outcome.php",
    "lis_result_sourcedid" =>                "feb-123-456-2929::28883",
    "tool_consumer_instance_guid" =>         "lmsng.school.edu",
    "tool_consumer_instance_description" =>  "University of School (LMSng)",
    "oauth_callback" =>                      "about:blank",
    "ext_submit" =>                          "Press to Launch"
 }.merge(options)

 tc = IMS::LTI::ToolConsumer.new(oauth_consumer_key, oauth_consumer_secret, params)
 tc.generate_launch_data
end
