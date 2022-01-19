require "rails_helper"

SAKAI_OPENID_CONFIGURATION = "https://dev1.sakaicloud.com/imsblis/lti13/well_known?key=47&clientId=c8ef5afa-55e4-488f-9271-92ce0ea944be&issuerURL=https%3A%2F%2Fdev1.sakaicloud.com&deploymentId=1".freeze
SAKAI_REGISTRATION_ENDPOINT = "https://dev1.sakaicloud.com/imsblis/lti13/registration_endpoint/43".freeze

MOODLE_OPENID_CONFIGURATION = "https://sandbox.moodledemo.net/mod/lti/openid-configuration.php".freeze
MOODLE_REGISTRATION_ENDPOINT = "https://sandbox.moodledemo.net/mod/lti/openid-registration.php".freeze

RSpec.describe LtiDynamicRegistrationsController, type: :controller do
  before do
    setup_application_instance
    allow(controller).to receive(:current_application).and_return(@application)
  end

  describe "index" do
    it "generates an LTI install for Sakai" do
      stub_request(:get, SAKAI_OPENID_CONFIGURATION).
        to_return(
          status: 200,
          body: sakai_openid_configuration.to_json,
        )

      stub_request(:post, SAKAI_REGISTRATION_ENDPOINT).
        to_return(
          status: 200,
          body: sakai_platform_registration_response.to_json,
        )

      post :index, params: sakai_init
      expect(response).to have_http_status(200)

      sites = Site.where(url: sakai_openid_configuration[:issuer])
      expect(sites.length).to equal(1)

      application_instances = ApplicationInstance.where(site_id: sites.first.id)
      expect(application_instances.length).to equal(1)

      client_id = sakai_platform_registration_response[:client_id]
      lti_installs = LtiInstall.where(client_id: client_id)
      expect(lti_installs.length).to equal(1)
    end

    it "handles multiple deployments for Sakai" do
      stub_request(:get, SAKAI_OPENID_CONFIGURATION).
        to_return(
          status: 200,
          body: sakai_openid_configuration.to_json,
        )

      stub_request(:post, SAKAI_REGISTRATION_ENDPOINT).
        to_return(
          status: 200,
          body: sakai_platform_registration_response.to_json,
        )

      post :index, params: sakai_init
      expect(response).to have_http_status(200)

      sites = Site.where(url: sakai_openid_configuration[:issuer])
      expect(sites.length).to equal(1)

      application_instances = ApplicationInstance.where(site_id: sites.first.id)
      expect(application_instances.length).to equal(1)

      expect(application_instances.first.lti_deployments.length).to equal(1)

      # Make a second post to test to ensure db entries aren't duplicated
      stub_request(:post, SAKAI_REGISTRATION_ENDPOINT).
        to_return(
          status: 200,
          body: sakai_platform_registration_response("2").to_json,
        )

      post :index, params: sakai_init
      expect(response).to have_http_status(200)

      sites = Site.where(url: sakai_openid_configuration[:issuer])
      expect(sites.length).to equal(1)

      application_instances = ApplicationInstance.where(site_id: sites.first.id)
      expect(application_instances.length).to equal(1)

      client_id = sakai_platform_registration_response[:client_id]
      lti_installs = LtiInstall.where(client_id: client_id)
      expect(lti_installs.length).to equal(1)

      expect(application_instances.first.lti_deployments.length).to equal(2)
    end

    it "generates an LTI install for Moodle" do
      stub_request(:get, MOODLE_OPENID_CONFIGURATION).
        to_return(
          status: 200,
          body: moodle_openid_configuration.to_json,
        )

      stub_request(:post, MOODLE_REGISTRATION_ENDPOINT).
        to_return(
          status: 200,
          body: moodle_platform_registration_response.to_json,
        )

      post :index, params: moodle_init
      expect(response).to have_http_status(200)
    end
  end
end

#
# Example responses from Sakai
#
def sakai_init
  {
    "openid_configuration": SAKAI_OPENID_CONFIGURATION,
    "registration_token": "1641258858:09e941d2-15cc-4389-be3f-dc1e04c14061",
  }
end

def sakai_openid_configuration
  {
    "issuer": "https://dev1.sakaicloud.com",
    "authorization_endpoint": "https://dev1.sakaicloud.com/imsoidc/lti13/oidc_auth",
    "token_endpoint": "https://dev1.sakaicloud.com/imsblis/lti13/token/43",
    "token_endpoint_auth_methods_supported": ["private_key_jwt"],
    "token_endpoint_auth_signing_alg_values_supported": ["RS256"],
    "jwks_uri": "https://dev1.sakaicloud.com/imsblis/lti13/keyset/43",
    "registration_endpoint": SAKAI_REGISTRATION_ENDPOINT,
    "scopes_supported": ["openid"],
    "response_types_supported": ["id_token"],
    "subject_types_supported": ["public", "pairwise"],
    "id_token_signing_alg_values_supported": ["RS256"],
    "claims_supported": ["iss", "aud"],
    "https://purl.imsglobal.org/spec/lti-platform-configuration": {
      "product_family_code": "sakailms.org",
      "version": "23-SNAPSHOT",
      "messages_supported": [
        {
          "type": "LtiResourceLinkRequest",
          "placements": [],
        },
        {
          "type": "LtiDeepLinkingRequest",
          "placements": [],
        },
      ],
      "variables": [
        "User.id",
        "Person.email.primary",
      ],
    },
  }
end

def sakai_platform_registration_response(deployment_id = "1")
  {
    "client_uri": "https://helloworld.atomicjolt.xyz/",
    "grant_types": ["implict", "client_credentials"],
    "application_type": "web",
    "initiate_login_uri": "https://helloworld.atomicjolt.xyz/lti_launches/init",
    "logo_uri": "https://helloworld.atomicjolt.xyz//atomicjolt.png",
    "https://purl.imsglobal.org/spec/lti-tool-configuration": {
      "domain": "https://helloworld.atomicjolt.xyz/",
      "target_link_uri": "https://helloworld.atomicjolt.xyz/lti_launches",
      "claims": ["iss", "sub", "name", "given_name", "family_name"],
      "description": "LTI Starter App by Atomic Jolt.",
      "messages": [
        {
          "target_link_uri": "https://helloworld.atomicjolt.xyz/lti_launches",
          "label": "LTI Starter App",
          "type": "LtiDeepLinkingRequest",
        },
      ],
      "deployment_id": deployment_id,
      "custom_parameters": {
        "canvas_user_timezone": "$Person.address.timezone",
        "canvas_course_id": "$Canvas.course.id",
        "canvas_root_account_id": "$Canvas.rootAccount.id",
        "canvas_account_id": "$Canvas.account.id",
        "canvas_section_ids": "$Canvas.course.sectionIds",
        "canvas_account_name": "$Canvas.account.name",
        "context_history": "$Context.id.history",
        "canvas_api_domain": "$Canvas.api.domain",
        "canvas_sis_id": "$Canvas.user.sisid",
        "canvas_user_id": "$Canvas.user.id",
        "canvas_term_name": "$Canvas.term.name",
      },
    },
    "redirect_uris": ["https://helloworld.atomicjolt.xyz/lti_launches"],
    "token_endpoint_auth_method": "private_key_jwt",
    "client_id": "5ad3e4e5-71d4-4c7e-9e38-4e4bea19c154",
    "scope": "https://purl.imsglobal.org/spec/lti-ags/scope/score",
    "jwks_uri": "https://helloworld.atomicjolt.xyz/jwks.json",
    "tos_uri": "https://www.atomicjolt.com/tos",
    "client_name": "LTI Starter App",
    "contacts": ["support@atomicjolt.com"],
    "response_types": ["id_token"],
    "policy_uri": "https://www.atomicjolt.com/privacy",
  }
end

#
# Example responses from Moodle
#
def moodle_init
  {
    "openid_configuration": "https://sandbox.moodledemo.net/mod/lti/openid-configuration.php",
    "registration_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IjNlNTliYzMzZTk0Njc1N2Y3OTQxIn0.eyJzdWIiOiJNd1gyUEZVQ2daQ1Rqb2wiLCJzY29wZSI6InJlZyIsImlhdCI6MTY0MTU4OTkyNCwiZXhwIjoxNjQxNTkzNTI0fQ.jdNW9lVXy-sfNwON_byOoz1Qmz1spUNJjgSvrF2b_hjpUvmPnILDGx0nN1GnYMG6OACeVROsemxJVsHf4KEu6Tz8F3adL0nwQYzDrLeCmdFSGRDqSdkF0eUBBJVQ9jPhASzHx0mfyZxwV6EVh4-Kn4Fl6b00uB_QdTEdmMFhOMBdZV7mr9Aelg0fhcsuZRXPOg_z_jxvuDTFEiGA-zt4cT4J2MVWTWuyANAsO0qD-5rUjB_TktpiYIzBjTmArrCft8KUfdJsPqusjTLHWJUtmAg_dc8wpCq9VlrH_bpYkBxULP9WsrwNg9Glk5Q7tH9fSOrPF58SSYncsld83_bgog",
  }
end

def moodle_openid_configuration
  {
    "issuer": "https://sandbox.moodledemo.net",
    "token_endpoint": "https://sandbox.moodledemo.net/mod/lti/token.php",
    "token_endpoint_auth_methods_supported": ["private_key_jwt"],
    "token_endpoint_auth_signing_alg_values_supported": ["RS256"],
    "jwks_uri": "https://sandbox.moodledemo.net/mod/lti/certs.php",
    "authorization_endpoint": "https://sandbox.moodledemo.net/mod/lti/auth.php",
    "registration_endpoint": MOODLE_REGISTRATION_ENDPOINT,
    "scopes_supported": [
      "https://purl.imsglobal.org/spec/lti-bo/scope/basicoutcome",
      "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem.readonly",
      "https://purl.imsglobal.org/spec/lti-ags/scope/result.readonly",
      "https://purl.imsglobal.org/spec/lti-ags/scope/score",
      "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem",
      "https://purl.imsglobal.org/spec/lti-nrps/scope/contextmembership.readonly",
      "https://purl.imsglobal.org/spec/lti-ts/scope/toolsetting",
      "openid",
    ],
    "response_types_supported": ["id_token"],
    "subject_types_supported": ["public", "pairwise"],
    "id_token_signing_alg_values_supported": ["RS256"],
    "claims_supported": [
      "sub",
      "iss",
      "name",
      "given_name",
      "family_name",
      "email",
    ],
    "https://purl.imsglobal.org/spec/lti-platform-configuration": {
      "product_family_code": "moodle",
      "version": "3.11.4 (Build: 20211108)",
      "messages_supported": [
        "LtiResourceLinkRequest",
        "LtiDeepLinkingRequest",
      ],
      "placements": ["AddContentMenu"],
      "variables": [
        "basic-lti-launch-request",
        "ContentItemSelectionRequest",
        "ToolProxyRegistrationRequest",
        "Context.id",
        "Context.title",
        "Context.label",
        "Context.id.history",
        "Context.sourcedId",
        "Context.longDescription",
        "Context.timeFrame.begin",
        "CourseSection.title",
        "CourseSection.label",
        "CourseSection.sourcedId",
        "CourseSection.longDescription",
        "CourseSection.timeFrame.begin",
        "CourseSection.timeFrame.end",
        "ResourceLink.id",
        "ResourceLink.title",
        "ResourceLink.description",
        "User.id",
        "User.username",
        "Person.name.full",
        "Person.name.given",
        "Person.name.family",
        "Person.email.primary",
        "Person.sourcedId",
        "Person.name.middle",
        "Person.address.street1",
        "Person.address.locality",
        "Person.address.country",
        "Person.address.timezone",
        "Person.phone.primary",
        "Person.phone.mobile",
        "Person.webaddress",
        "Membership.role",
        "Result.sourcedId",
        "Result.autocreate",
        "BasicOutcome.sourcedId",
        "BasicOutcome.url",
        "Moodle.Person.userGroupIds",
      ],
    },
  }
end

def moodle_platform_registration_response
  {
    "client_id": "MwX2PFUCgZCTjol",
    "response_types": ["id_token"],
    "jwks_uri": "https://helloworld.atomicjolt.xyz/jwks.json",
    "initiate_login_uri": "https://helloworld.atomicjolt.xyz/lti_launches/init",
    "grant_types": [
      "client_credentials",
      "implicit",
    ],
    "redirect_uris": ["https://helloworld.atomicjolt.xyz/lti_launches"],
    "application_type": "web",
    "token_endpoint_auth_method": "private_key_jwt",
    "client_name": "LTI Starter App",
    "logo_uri": "https://helloworld.atomicjolt.xyz//atomicjolt.png",
    "scope": "",
    "https://purl.imsglobal.org/spec/lti-tool-configuration": {
      "version": "1.3.0",
      "deployment_id": "2",
      "target_link_uri": "https://helloworld.atomicjolt.xyz/lti_launches",
      "domain": "helloworld.atomicjolt.xyz",
      "description": "LTI Starter App by Atomic Jolt.",
      "messages": [
        {
          "type": "LtiDeepLinkingRequest",
          "target_link_uri": "https://helloworld.atomicjolt.xyz/lti_launches",
        },
      ],
      "custom_parameters": {
        "context_history": "$Context.id.history",
        "canvas_sis_id": "$Canvas.user.sisid",
        "canvas_user_id": "$Canvas.user.id",
        "canvas_course_id": "$Canvas.course.id",
        "canvas_term_name": "$Canvas.term.name",
        "canvas_account_id": "$Canvas.account.id",
        "canvas_api_domain": "$Canvas.api.domain",
        "canvas_section_ids": "$Canvas.course.sectionIds",
        "canvas_account_name": "$Canvas.account.name",
        "canvas_user_timezone": "$Person.address.timezone",
        "canvas_root_account_id": "$Canvas.rootAccount.id",
      },
      "claims": [
        "sub",
        "iss",
        "name",
        "family_name",
        "given_name",
      ],
    },
  }
end
