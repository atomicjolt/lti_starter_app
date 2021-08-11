module LtiAdvantage
  class Definitions
    LTI_VERSION = "https://purl.imsglobal.org/spec/lti/claim/version".freeze
    LAUNCH_PRESENTATION = "https://purl.imsglobal.org/spec/lti/claim/launch_presentation".freeze
    DEPLOYMENT_ID = "https://purl.imsglobal.org/spec/lti/claim/deployment_id".freeze
    MESSAGE_TYPE = "https://purl.imsglobal.org/spec/lti/claim/message_type".freeze

    # Claims
    CONTEXT_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/context".freeze
    RESOURCE_LINK_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/resource_link".freeze
    TOOL_PLATFORM_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/tool_platform".freeze
    AGS_CLAIM = "https://purl.imsglobal.org/spec/lti-ags/claim/endpoint".freeze

    MENTOR_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/role_scope_mentor".freeze
    ROLES_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/roles".freeze

    CUSTOM_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/custom".freeze
    EXTENSION_CLAIM = "http://www.ExamplePlatformVendor.com/session".freeze

    LIS_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/lis".freeze
    TARGET_LINK_URI_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/target_link_uri".freeze
    LTI11_LEGACY_USER_ID_CLAIM = "https://purl.imsglobal.org/spec/lti/claim/lti11_legacy_user_id".freeze
    DEEP_LINKING_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/deep_linking_settings".freeze
    DEEP_LINKING_DATA_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/data".freeze
    DEEP_LINKING_TOOL_MSG_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/msg".freeze
    DEEP_LINKING_TOOL_LOG_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/log".freeze
    CONTENT_ITEM_CLAIM = "https://purl.imsglobal.org/spec/lti-dl/claim/content_items".freeze
    NAMES_AND_ROLES_CLAIM = "https://purl.imsglobal.org/spec/lti-nrps/claim/namesroleservice".freeze

    NAMES_AND_ROLES_SERVICE_VERSIONS = ["2.0"].freeze

    CALIPER_CLAIM = "https://purl.imsglobal.org/spec/lti-ces/claim/caliper-endpoint-service".freeze

    TOOL_LAUNCH_CALIPER_CONTEXT = "http://purl.imsglobal.org/ctx/caliper/v1p1/ToolLaunchProfile-extension".freeze
    TOOL_USE_CALIPER_CONTEXT = "http://purl.imsglobal.org/ctx/caliper/v1p1".freeze

    # Scopes
    AGS_SCOPE_LINE_ITEM = "https://purl.imsglobal.org/spec/lti-ags/scope/lineitem".freeze
    AGS_SCOPE_RESULT = "https://purl.imsglobal.org/spec/lti-ags/scope/result.readonly".freeze
    AGS_SCOPE_SCORE = "https://purl.imsglobal.org/spec/lti-ags/scope/score".freeze
    NAMES_AND_ROLES_SCOPE = "https://purl.imsglobal.org/spec/lti-nrps/scope/contextmembership.readonly".freeze
    CALIPER_SCOPE = "https://purl.imsglobal.org/spec/lti-ces/v1p0/scope/send".freeze

    STUDENT_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student".freeze
    INSTRUCTOR_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Instructor".freeze
    LEARNER_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Learner".freeze
    MENTOR_SCOPE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Mentor".freeze
    MENTOR_ROLE_SCOPE = "a62c52c02ba262003f5e".freeze

    # Launch contexts
    COURSE_CONTEXT = "http://purl.imsglobal.org/vocab/lis/v2/course#CourseOffering".freeze
    ACCOUNT_CONTEXT = "Account".freeze

    # Specfies all available scopes.
    def self.scopes
      [
        AGS_SCOPE_LINE_ITEM,
        AGS_SCOPE_RESULT,
        AGS_SCOPE_SCORE,
        NAMES_AND_ROLES_SCOPE,
      ]
    end

    CANVAS_PUBLIC_LTI_KEYS_URL = "https://canvas.instructure.com/api/lti/security/jwks".freeze
    CANVAS_OIDC_URL = "https://canvas.instructure.com/api/lti/authorize_redirect".freeze
    CANVAS_AUTH_TOKEN_URL = "https://canvas.instructure.com/login/oauth2/token".freeze

    CANVAS_BETA_PUBLIC_LTI_KEYS_URL = "https://canvas.beta.instructure.com/api/lti/security/jwks".freeze
    CANVAS_BETA_AUTH_TOKEN_URL = "https://canvas.beta.instructure.com/login/oauth2/token".freeze
    CANVAS_BETA_OIDC_URL = "https://canvas.beta.instructure.com/api/lti/authorize_redirect".freeze

    CANVAS_SUBMISSION_TYPE = "https://canvas.instructure.com/lti/submission_type".freeze

    # Roles
    # Below are all the roles specified in the LTI 1.3 spec. (https://www.imsglobal.org/spec/lti/v1p3#role-vocabularies-0)
    ## Core system roles
    ADMINISTRATOR_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#Administrator".freeze
    NONE_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#None".freeze
    ## Non‑core system roles
    ACCOUNT_ADMIN_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#AccountAdmin".freeze
    CREATOR_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#Creator".freeze
    SYS_ADMIN_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#SysAdmin".freeze
    SYS_SUPPORT_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#SysSupport".freeze
    USER_SYSTEM_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/system/person#User".freeze
    ## Core institution roles
    ADMINISTRATOR_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Administrator".freeze
    FACULTY_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Faculty".freeze
    GUEST_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Guest".freeze
    NONE_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#None".freeze
    OTHER_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Other".freeze
    STAFF_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Staff".freeze
    STUDENT_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Student".freeze
    ## Non‑core institution roles
    ALUMNI_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Alumni".freeze
    INSTRUCTOR_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Instructor".freeze
    LEARNER_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Learner".freeze
    MEMBER_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Member".freeze
    MENTOR_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Mentor".freeze
    OBSERVER_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#Observer".freeze
    PROSPECTIVE_STUDENT_INSTITUTION_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/institution/person#ProspectiveStudent".freeze
    ## Core context roles
    ADMINISTRATOR_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Administrator".freeze
    CONTENT_DEVELOPER_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#ContentDeveloper".freeze
    INSTRUCTOR_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Instructor".freeze
    LEARNER_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Learner".freeze
    MENTOR_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Mentor".freeze
    ## Non‑core context roles
    MANAGER_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Manager".freeze
    MEMBER_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Member".freeze
    OFFICER_CONTEXT_ROLE = "http://purl.imsglobal.org/vocab/lis/v2/membership#Officer".freeze

    ADMINISTRATOR_ROLES = [
      ADMINISTRATOR_SYSTEM_ROLE,
      ACCOUNT_ADMIN_SYSTEM_ROLE,
      ADMINISTRATOR_INSTITUTION_ROLE,
      ADMINISTRATOR_CONTEXT_ROLE,
    ].freeze

    INSTRUCTOR_ROLES = [
      INSTRUCTOR_INSTITUTION_ROLE,
      INSTRUCTOR_CONTEXT_ROLE,
    ].freeze

    STUDENT_ROLES = [
      STUDENT_INSTITUTION_ROLE,
      LEARNER_CONTEXT_ROLE,
    ].freeze

    def self.lms_host(payload)
      host = if deep_link_launch?(payload)
               payload.dig(LtiAdvantage::Definitions::DEEP_LINKING_CLAIM, "deep_link_return_url")
             else
               payload.dig(LtiAdvantage::Definitions::LAUNCH_PRESENTATION, "return_url")
             end
      UrlHelper.safe_host(host)
    end

    def self.lms_url(payload)
      "https://#{lms_host(payload)}"
    end

    def self.deep_link_launch?(jwt_body)
      jwt_body[LtiAdvantage::Definitions::MESSAGE_TYPE] == "LtiDeepLinkingRequest"
    end

    def self.names_and_roles_launch?(jwt_body)
      return false unless jwt_body[LtiAdvantage::Definitions::NAMES_AND_ROLES_CLAIM]

      jwt_body[LtiAdvantage::Definitions::NAMES_AND_ROLES_CLAIM]["service_versions"] ==
        LtiAdvantage::Definitions::NAMES_AND_ROLES_SERVICE_VERSIONS
    end

    def self.assignment_and_grades_launch?(jwt_body)
      jwt_body[LtiAdvantage::Definitions::AGS_CLAIM]
    end

  end
end
