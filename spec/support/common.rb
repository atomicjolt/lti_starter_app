# Setup a user and an admin
def setup_users
  setup_application_instance
  @user = FactoryBot.create(:user)
  @user.confirm
  @user_token = AuthToken.issue_token(
    {
      application_instance_id: @application_instance.id,
      user_id: @user.id,
    },
  )

  @admin = FactoryBot.create(:user)
  @admin.confirm
  @admin.add_to_role("administrator")
  @admin_token = AuthToken.issue_token(
    {
      application_instance_id: @application_instance.id,
      user_id: @user.id,
    },
  )
end

# Sets up users in the 3 most common roles for lti launches
def setup_lti_users
  setup_application_instance
  @student = FactoryBot.create(:user)
  @student.confirm
  @student_token = AuthToken.issue_token(
    {
      application_instance_id: @application_instance.id,
      user_id: @student.id,
      context_id: @lms_course_id,
      lti_roles: ["urn:lti:role:ims/lis/Learner"],
      lms_course_id: @lms_course_id,
    },
  )

  @instructor = FactoryBot.create(:user)
  @instructor.confirm
  @instructor_token = AuthToken.issue_token(
    {
      application_instance_id: @application_instance.id,
      user_id: @instructor.id,
      context_id: @lms_course_id,
      lti_roles: ["urn:lti:role:ims/lis/Instructor"],
      lms_course_id: @lms_course_id,
    },
  )

  @admin = FactoryBot.create(:user)
  @admin.confirm
  @admin.add_to_role("administrator")
  @admin_token = AuthToken.issue_token(
    {
      application_instance_id: @application_instance.id,
      user_id: @admin.id,
      context_id: @lms_course_id,
      lti_roles: ["urn:lti:role:ims/lis/Administrator"],
      lms_course_id: @lms_course_id,
    },
  )
end

def setup_application_and_instance
  @canvas_api_permissions = {
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
  @application = FactoryBot.create(
    :application,
    canvas_api_permissions: @canvas_api_permissions,
  )
  @application_instance = FactoryBot.create(:application_instance, application: @application)
  allow(controller).to receive(:current_application_instance).and_return(@application_instance)
end

def setup_application_instance(mock_helper: true)
  @application_instance = global_application_instance
  @application = @application_instance.application
  @canvas_api_permissions = @application.canvas_api_permissions

  if defined?(controller) && mock_helper
    allow(controller).to receive(:current_application_instance).and_return(global_application_instance)
  end
end
