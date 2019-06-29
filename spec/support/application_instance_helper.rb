module ApplicationInstanceHelper
  def self.make_application_instance
    canvas_api_permissions = {
      default: [],
      common: [],
      LIST_ACCOUNTS: [
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:role:ims/lis/Instructor",
      ],
      LIST_YOUR_COURSES: [
        "urn:lti:sysrole:ims/lis/SysAdmin",
        "urn:lti:sysrole:ims/lis/Administrator",
        "urn:lti:instrole:ims/lis/Administrator",
        "urn:lti:role:ims/lis/Instructor",
        "urn:lti:role:ims/lis/Learner",
      ],
    }
    application = FactoryBot.create(
      :application,
      canvas_api_permissions: canvas_api_permissions,
    )

    default_config = {}

    FactoryBot.create(
      :application_instance,
      application: application,
      lti_key: "global_test",
      tenant: "global_test",
      config: default_config,
    )
  end

  def get_application_instance
    @application_instance ||= ApplicationInstance.find_by(lti_key: "global_test")
  end
end
