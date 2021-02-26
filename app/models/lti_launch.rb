# When an LtiLaunch class is instantiated, it automatically generates a token 
# because of the "has_secure_token" method. This token can be planted as a URL
# parameter in the "external_tool" url tag (in this case the Canvas LMS - see 
# Canvas API Assignment Docs: https://canvas.instructure.com/doc/api/assignments.html). 
#
# For example: 
# "external_tool" : { url: https://your-lti-tool-domain.xyz?your_launch_route/launch_token=generated_token }
#
# When the LMS accesses your provided route in the external tool URL, the launch_token
# param (the generated token) can then be used to lookup configurations and
# context about the LMS item in which the external_tool URL was placed. See the LtiLaunches
# table for available columns here:
# https://github.com/atomicjolt/lti_starter_app/blob/ea7ca45a9e5786747353aa14d06a32a5be6460cd/db/schema.rb#L192
#
# # ==== Example
#     # Store your config and launch token in the database
#     lti_launch = LtiLaunch.create!(
#       config: { some_configuration: ... }, # A hash of relevant item info
#       tool_consumer_instance_guid: tool_consumer_instance_guid,
#       context_id: context_id,
#     )
#     
#     # Get the generated token and place it in the external_url
#     generated_token = lti_launch.token
#     external_url = "https://your-lti-tool-domain.xyz/lti_launches?launch_token=#{generated_token}"
#
#     # Make a call to your LMS API including the external_url in your payload.
#     ...
#

class LtiLaunch < ApplicationRecord
  has_secure_token
  serialize :config, HashSerializer
end
