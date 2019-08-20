module ApplicationInstanceHelper

  GLOBAL_LTI_KEY = "global_test"

  def self.make_application_instance
    canvas_api_permissions = {
      default: [],
      common: [
        "administrator",
      ],
      LIST_YOUR_COURSES: [
        "canvas_oauth_user",
      ],
      LIST_ACCOUNTS: [
        "canvas_oauth_user",
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:role:ims/lis/Instructor",
      ],
      LIST_ENROLLMENTS_COURSES: [
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:role:ims/lis/Instructor",
      ],
      GET_SUB_ACCOUNTS_OF_ACCOUNT: [
        "canvas_oauth_user",
      ],
      CREATE_NEW_SUB_ACCOUNT: [],
      UPDATE_ACCOUNT: [],
      # CREATE_ASSIGNMENT: [],
      # CREATE_ASSIGNMENT_OVERRIDE: [],
      # EDIT_ASSIGNMENT: [],
      # DELETE_ASSIGNMENT: [],
      # LIST_ASSIGNMENTS: [],
    }
    application = FactoryBot.create(
      :application,
      canvas_api_permissions: canvas_api_permissions,
    )

    default_config = {}

    bundle = Bundle.find_or_create_by(key: GLOBAL_LTI_KEY)

    bundle_instance = FactoryBot.create(
      :bundle_instance,
      bundle: bundle
    )

    FactoryBot.create(
      :application_instance,
      application: application,
      lti_key: GLOBAL_LTI_KEY,
      tenant: GLOBAL_LTI_KEY,
      config: default_config,
      bundle_instance: bundle_instance,
    )
  end

  def global_application_instance
    @global_application_instance ||= ApplicationInstance.find_by(lti_key: GLOBAL_LTI_KEY)
  end
end
