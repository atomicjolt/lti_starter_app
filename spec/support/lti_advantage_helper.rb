def setup_canvas_lti_advantage(
  application_instance:,
  client_id: FactoryBot.generate(:client_id),
  iss: "https://canvas.instructure.com",
  lti_user_id: SecureRandom.uuid,
  context_id: SecureRandom.hex(15),
  message_type: "LtiResourceLinkRequest",
  resource_link_id: SecureRandom.hex,
  launch_token: nil,
  controller_name: "lti_launches",
  target_link_uri: nil,
  host: "helloworld.atomicjolt.xyz",
  roles: nil,
  jwk: nil
)
  @iss = iss
  @client_id = client_id
  @lti_user_id = lti_user_id
  @context_id = context_id
  @deployment_id = "#{SecureRandom.hex(5)}:#{@context_id}"
  @message_type = message_type
  @resource_link_id = resource_link_id

  AtomicLti::Jwk.find_or_create_by(domain: nil)

  # Add some platforms
  AtomicLti::Platform.create_with(
    jwks_url: "https://canvas.instructure.com/api/lti/security/jwks",
    token_url: "https://canvas.instructure.com/login/oauth2/token",
    oidc_url: "https://canvas.instructure.com/api/lti/authorize_redirect"
  ).find_or_create_by(iss: "https://canvas.instructure.com")

  roles ||=
    [
      "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Instructor",
      "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student",
      "http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor",
      "http://purl.imsglobal.org/vocab/lis/v2/system/person#User",
    ]
  target_link_uri ||= if launch_token.present?
                        "https://#{host}/#{controller_name}/#{launch_token}"
                      else
                        "https://#{host}/#{controller_name}"
                      end

  site = Site.find_or_create_by(url: "https://atomicjolt.instructure.com")
  application_instance.site = site
  application_instance.save!

  application_instance.application.lti_installs.create!(
    iss: @iss,
    client_id: @client_id,
    jwks_url: AtomicLti::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL,
    token_url: AtomicLti::Definitions::CANVAS_AUTH_TOKEN_URL,
    oidc_url: AtomicLti::Definitions::CANVAS_OIDC_URL,
  )

  @atomic_lti_deployment = AtomicLti::Deployment.create!(iss: @iss, deployment_id: @deployment_id, client_id: @client_id)
  AtomicLti::Install.create!(iss: @iss, client_id: @client_id)
  AtomicTenant::LtiDeployment.create!(iss: @iss, deployment_id: @deployment_id, application_instance_id: application_instance.id)

  # @lti_deployment = application_instance.lti_deployments.create!(
  #   deployment_id: @deployment_id,
  #   lti_install: application_instance.application.lti_installs.last,
  # )

  # jwk ||= application_instance.application.current_jwk
  # stub_canvas_jwk(application_instance.application)

  jwk = AtomicLti::Jwk.new
  jwk.generate_keys
  stub_request(:get, AtomicLti::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL).
    to_return(
      status: 200,
      body: { keys: [jwk].map(&:to_json) }.to_json,
      headers: canvas_headers,
    )

  @id_token = JWT.encode(
    build_payload(
      client_id: @client_id,
      iss: @iss,
      lti_user_id: @lti_user_id,
      context_id: @context_id,
      message_type: @message_type,
      resource_link_id: @resource_link_id,
      deployment_id: @deployment_id,
      roles: roles,
      target_link_uri: target_link_uri,
    ),
    jwk.private_key,
    jwk.alg,
    kid: jwk.kid,
    typ: "JWT",
  )

  @lti_token = JWT.decode(@id_token, nil, false)

  nonce = SecureRandom.hex(64)
  AtomicLti::OpenIdState.create!(nonce: nonce)
  state = AtomicLti::AuthToken.issue_token(
    {
      nonce: nonce,
    },
  )

  # For controller specs
  if @request.present?
    @request.host = host
    @request.env["HTTPS"] = "on"
  end

  @params = {
    "id_token" => @id_token,
    "state" => state,
  }
end

def stub_canvas_jwk(application)
  stub_request(:get, AtomicLti::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL).
    to_return(
      status: 200,
      body: { keys: application.jwks.map(&:to_json) }.to_json,
      headers: canvas_headers,
    )
end

def stub_canvas_jwks(jwks: [])
  stub_request(:get, AtomicLti::Definitions::CANVAS_PUBLIC_LTI_KEYS_URL).
    to_return(
      status: 200,
      body: { keys: jwks.map(&:to_json) }.to_json,
      headers: canvas_headers,
    )
end

def make_deep_link_jwt(application_instance_id, iss, deployment_id, context_id)
  setup_application_instance
  user = FactoryBot.create(:user)
  user.confirm
  AuthToken.issue_token(
    {
      application_instance_id: application_instance_id,
      user_id: user.id,
      iss: iss,
      AtomicLti::Definitions::DEPLOYMENT_ID => deployment_id,
      context_id: context_id,
    },
  )
end

def resource_link_claim(id)
  {
    "https://purl.imsglobal.org/spec/lti/claim/resource_link": {
      "id": id,
      "description": nil,
      "title": "Lesson 1",
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
  }
end

def deep_link_settings_claim
  {
    "https://purl.imsglobal.org/spec/lti-dl/claim/deep_linking_settings": {
      "deep_link_return_url": "https://atomicjolt.instructure.com/courses/3505/deep_linking_response?modal=true",
      "accept_types": ["link", "file", "html", "ltiResourceLink", "image"],
      "accept_presentation_document_targets": ["embed", "iframe", "window"],
      "accept_media_types": "image/*,text/html,application/vnd.ims.lti.v1.ltilink,*/*",
      "accept_multiple": true,
      "auto_create": false,
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
  }
end

def build_payload(
  client_id:,
  iss:,
  lti_user_id:,
  context_id:,
  message_type:,
  resource_link_id:,
  deployment_id:,
  roles:,
  target_link_uri:
)

  exp = 24.hours.from_now
  nonce = SecureRandom.hex(10)
  payload = {
    "https://purl.imsglobal.org/spec/lti/claim/message_type": message_type,
    "https://purl.imsglobal.org/spec/lti/claim/version": "1.3.0",
    "https://purl.imsglobal.org/spec/lti-ags/claim/endpoint": {
      "scope": [
        "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem",
        "https://purl.imsglobal.org/spec/lti-ags/scope/result.readonly",
        "https://purl.imsglobal.org/spec/lti-ags/scope/score",
        "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem.readonly",
      ],
      "lineitems": "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items",
      "lineitem": "https://atomicjolt.instructure.com/api/lti/courses/3334/line_items/2444",
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
    "aud": client_id,
    "azp": client_id,
    "https://purl.imsglobal.org/spec/lti/claim/deployment_id": deployment_id,
    "exp": exp.to_i,
    "email": "atomicjolt@example.com",
    "iat": Time.now.to_i,
    "iss": iss,
    "nonce": nonce,
    "sub": lti_user_id,
    "https://purl.imsglobal.org/spec/lti/claim/target_link_uri": target_link_uri,
    "https://purl.imsglobal.org/spec/lti/claim/context": {
      "id": context_id,
      "label": "Intro Geology",
      "title": "Introduction to Geology - Ball",
      "type": [
        "http://purl.imsglobal.org/vocab/lis/v2/course#CourseOffering",
      ],
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
    "https://purl.imsglobal.org/spec/lti/claim/tool_platform": {
      "guid": "4MRcxnx6vQbFXxhLb8005m5WXFM2Z2i8lQwhJ1QT:canvas-lms",
      "name": "Atomic Jolt",
      "version": "cloud",
      "product_family_code": "canvas",
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
    "https://purl.imsglobal.org/spec/lti/claim/launch_presentation": {
      "document_target": "iframe",
      "height": 500,
      "width": 500,
      "return_url": "https://atomicjolt.instructure.com/courses/3334/external_content/success/external_tool_redirect",
      "locale": "en",
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
    "locale": "en",
    "https://purl.imsglobal.org/spec/lti/claim/roles": roles,
    "https://purl.imsglobal.org/spec/lti/claim/custom": {
      "canvas_sis_id": "$Canvas.user.sisid",
      "canvas_user_id": "1",
      "canvas_api_domain": "atomicjolt.instructure.com",
      "canvas_assignment_id": "123",
      "canvas_course_id": "1",
    },
    "https://purl.imsglobal.org/spec/lti-nrps/claim/namesroleservice": {
      "context_memberships_url": "https://atomicjolt.instructure.com/api/lti/courses/3334/names_and_roles",
      "service_versions": [
        "2.0",
      ],
      "validation_context": nil,
      "errors": {
        "errors": {},
      },
    },
    "errors": {
      "errors": {},
    },
  }

  payload.merge!(resource_link_claim(resource_link_id)) if @message_type == "LtiResourceLinkRequest"
  payload.merge!(deep_link_settings_claim) if @message_type == "LtiDeepLinkingRequest"

  payload
end

def setup_atomic_lti_values(application_instance: nil)
  request.env["atomic.validated.id_token"] = @id_token
  request.env["atomic.validated.decoded_id_token"] = @decoded_id_token

  if application_instance
    request.env["atomic.validated.application_instance_id"] = application_instance.id
  end
end
