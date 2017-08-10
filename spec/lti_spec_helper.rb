# Derived from https://github.com/instructure/lti_originality_report_example
# MIT License

# Copyright (c) 2017 Instructure, Inc.
# Copyright (c) 2017 Atomic Jolt

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

RSpec.shared_context "lti_spec_helper", shared_context: :metadata do
  let(:registration_message) do
    {
      lti_message_type: "ToolProxyRegistrationRequest",
      lti_version: "LTI-2p0",
      reg_password: "d731e340-0fed-497a-9f92-6e1f6cf4eb21",
      tc_profile_url: "http://example.com/api/lti/courses/2/tool_consumer_profile",
      launch_presentation_return_url: "http://example.com/courses/2/lti/registration_return",
      launch_presentation_document_target: "iframe",
      oauth2_access_token_url: "http://example.com/api/lti/courses/2/authorize"
    }
  end
  let(:access_token) { "eya34a34.a4453ad.12323234a" }
  let(:tp_response) do
    {
      "@context" => "http =>//purl.imsglobal.org/ctx/lti/v2/ToolProxyId",
      "@type" => "ToolProxy",
      "tool_proxy_guid" => tool_proxy_guid,
      "tc_half_shared_secret" => tc_half_shared_secret
    }.to_json
  end
  let(:tool_proxy_guid) { "00d97c7d-f163-44aa-9921-c7c186a5e809" }
  let(:tool_proxy) { ToolProxy.create!(guid: tool_proxy_guid, tcp_url: "test.com", base_url: "tc.com", shared_secret: "secret") }
  let(:tc_half_shared_secret) { "0e5de8345149b53c28e49f1da467f077b6ecf8fd1e29cff9d2bea693105ac353e4742b168ca594f2d0346ebc968454ce57f0a84017b6f4b2d279f08797d66928" }
  let(:tool_consumer_profile) do
    '{
       "lti_version":"LTI-2p0",
       "guid":"cf9da3cf-7273-4e11-a423-0fbd0416057e",
       "capability_offered":[
          "basic-lti-launch-request",
          "User.id",
          "Canvas.placements.similarityDetection"
       ],
       "security_profile":[
          {
             "security_profile_name":"lti_oauth_hash_message_security",
             "digest_algorithm":"HMAC-SHA1"
          },
          {
             "security_profile_name":"oauth2_access_token_ws_security",
             "digest_algorithm":"HS256"
          }
       ],
       "product_instance":{
          "guid":"edea7cb339bf18da4132895e1a44e4b8ee7bd8d9.example.com",
          "product_info":{
             "product_version":"none",
             "product_family":{
                "code":"canvas",
                "vendor":{
                   "code":"https:\/\/instructure.com",
                   "vendor_name":{
                      "default_value":"Instructure",
                      "key":"vendor.name"
                   },
                   "timestamp":"2008-03-27T06:00:00Z"
                }
             },
             "product_name":{
                "default_value":"Canvas by Instructure",
                "key":"product.name"
             }
          },
          "service_owner":{
             "description":{
                "default_value":"Westons Dev Org",
                "key":"service_owner.description"
             },
             "service_owner_name":{
                "default_value":"Westons Dev Org",
                "key":"service_owner.name"
             }
          }
       },
       "service_offered":[
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_proxy",
             "format":[
                "application\/vnd.ims.lti.v2.toolproxy+json"
             ],
             "action":[
                "POST"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#ToolProxy.collection",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/tool_proxy\/{tool_proxy_guid}",
             "format":[
                "application\/vnd.ims.lti.v2.toolproxy+json"
             ],
             "action":[
                "GET"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#ToolProxy.item",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/courses\/2\/authorize",
             "format":[
                "application\/json"
             ],
             "action":[
                "POST"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#vnd.Canvas.authorization",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/courses\/2\/originality-report",
             "format":[
                "application\/json"
             ],
             "action":[
                "POST", "PUT", "GET"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#vnd.Canvas.OriginalityReport",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/tool_settings\/tool_proxy\/{tool_proxy_id}",
             "format":[
                "application\/vnd.ims.lti.v2.toolsettings+json",
                "application\/vnd.ims.lti.v2.toolsettings.simple+json"
             ],
             "action":[
                "GET",
                "PUT"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#ToolProxySettings",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/tool_settings\/bindings\/{binding_id}",
             "format":[
                "application\/vnd.ims.lti.v2.toolsettings+json",
                "application\/vnd.ims.lti.v2.toolsettings.simple+json"
             ],
             "action":[
                "GET",
                "PUT"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#ToolProxyBindingSettings",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/tool_settings\/links\/{tool_proxy_id}",
             "format":[
                "application\/vnd.ims.lti.v2.toolsettings+json",
                "application\/vnd.ims.lti.v2.toolsettings.simple+json"
             ],
             "action":[
                "GET",
                "PUT"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#LtiLinkSettings",
             "@type":"RestService"
          },
          {
             "endpoint":"http:\/\/example.com\/api\/lti\/subscriptions",
             "format":[
                "application\/json"
             ],
             "action":[
                "POST",
                "GET",
                "PUT",
                "DELETE"
             ],
             "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e#vnd.Canvas.webhooksSubscription",
             "@type":"RestService"
          }
       ],
       "@id":"http:\/\/example.com\/api\/lti\/courses\/2\/tool_consumer_profile\/cf9da3cf-7273-4e11-a423-0fbd0416057e",
       "@type":"ToolConsumerProfile",
       "@context":[
          "http:\/\/purl.imsglobal.org\/ctx\/lti\/v2\/ToolConsumerProfile"
       ]
    }'
  end
end
