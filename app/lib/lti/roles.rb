module Lti
  module Roles
    # Context level roles
    INSTRUCTOR = "urn:lti:role:ims\/lis\/Instructor".freeze
    TA = "urn:lti:role:ims\/lis\/TeachingAssistant".freeze
    ADMIN = "urn:lti:role:ims\/lis\/Administrator".freeze
    LEARNER = "urn:lti:role:ims/lis/Learner".freeze
    CONTENT_DEVELOPER = "urn:lti:role:ims/lis/ContentDeveloper".freeze

    # System level roles
    SYS_SYSADMIN = "urn:lti:sysrole:ims\/lis\/SysAdmin".freeze
    SYS_ADMIN = "urn:lti:sysrole:ims\/lis\/Administrator".freeze

    # Institution level roles
    INST_ADMIN = "urn:lti:instrole:ims\/lis\/Administrator".freeze
    INST_INSTRUCTOR = "urn:lti:instrole:ims\/lis\/Instructor".freeze

    ADMIN_ROLES = [
      ADMIN,
      SYS_SYSADMIN,
      SYS_ADMIN,
      INST_ADMIN,
    ].freeze

    NON_STUDENT_ROLES = [
      INSTRUCTOR,
      TA,
      ADMIN,
      SYS_SYSADMIN,
      SYS_ADMIN,
      INST_ADMIN,
    ].freeze
  end
end
