module LtiAdvantage
  class Definitions
    LTI_VERSION = "https://purl.imsglobal.org/spec/lti/claim/version"
    LAUNCH_PRESENTATION = "https://purl.imsglobal.org/spec/lti/claim/launch_presentation"
    DEPLOYMENT_ID = "https://purl.imsglobal.org/spec/lti/claim/deployment_id"
    CONTEXT_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/context"
    RESOURCE_LINK_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/resource_link"
    TOOL_PLATFORM_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/tool_platform"
    AGS_CLAIM = "https://purl.imsglobal.org/spec/lti-ags/claim/endpoint"
    AGS_SCOPE_LINE_ITEM = "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem"
    AGS_SCOPE_RESULT = "https://purl.imsglobal.org/spec/lti-ags/scope/result.readonly"
    AGS_SCOPE_SCORE = "https://purl.imsglobal.org/spec/lti-ags/scope/score"
    MESSAGE_TYPE = "https://purl.imsglobal.org/spec/lti/claim/message_type"
    CUSTOM_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/custom"
    EXTENSION_CLAIM = "http://www.ExamplePlatformVendor.com/session"
    ROLES_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/roles"
    STUDENT_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student"
    INSTRUCTOR_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Instructor"
    LEARNER_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Learner"
    MENTOR_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Mentor"
    MENTOR_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/role_scope_mentor"
    MENTOR_ROLE_SCOPE = "a62c52c02ba262003f5e"
    LIS_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/lis"
    TARGET_LINK_URI_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/target_link_uri"
    LTI11_LEGACY_USER_ID_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/lti11_legacy_user_id"
    DEEP_LINKING_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/deep_linking_settings"
    DEEP_LINKING_DATA_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/data"
    DEEP_LINKING_TOOL_MSG_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/msg"
    DEEP_LINKING_TOOL_LOG_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/log"
    CONTENT_ITEM_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/content_items"
    NAMES_AND_ROLES_CLAIM = "https://purl.imsglobal.org/spec/lti-nrps/claim/namesroleservice"
    NAMES_AND_ROLES_SERVICE_VERSIONS = ["2.0"]
    NAMES_AND_ROLES_SCOPE = "https://purl.imsglobal.org/spec/lti-nrps/scope/contextmembership.readonly"
    CALIPER_CLAIM = "https://purl.imsglobal.org/spec/lti-ces/claim/caliper-endpoint-service"
    CALIPER_SCOPE = "https://purl.imsglobal.org/spec/lti-ces/v1p0/scope/send"
    TOOL_LAUNCH_CALIPER_CONTEXT = "http://purl.imsglobal.org/ctx/caliper/v1p1/ToolLaunchProfile-extension"
    TOOL_USE_CALIPER_CONTEXT = "http://purl.imsglobal.org/ctx/caliper/v1p1"

    def self.scopes
      [
        AGS_SCOPE_LINE_ITEM,
        AGS_SCOPE_RESULT,
        AGS_SCOPE_SCORE,
        NAMES_AND_ROLES_SCOPE
      ].join(" ")
    end
  end
end