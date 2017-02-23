//
// Courses
//
// List your courses
// Returns the list of active courses for the current user.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses
//
// Example:
// const query = {
//   enrollment_type
//   enrollment_role
//   enrollment_role_id
//   enrollment_state
//   include
//   state
// }
// return canvasRequest(list_your_courses, {}, query);
export const listYourCourses = { type: 'LIST_YOUR_COURSES', method: 'get', key: 'list_your_courses', required: [] };

// List courses for a user
// Returns a list of active courses for this user. To view the course list for a user other than yourself, you must be either an observer of that user or an administrator.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: users/{user_id}/courses
//
// Example:
// const query = {
//   include
//   state
//   enrollment_state
// }
// return canvasRequest(list_courses_for_user, {user_id}, query);
export const listCoursesForUser = { type: 'LIST_COURSES_FOR_USER', method: 'get', key: 'list_courses_for_userlist_courses_for_user_user_id', required: ['user_id'] };

// Create a new course
// Create a new course
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: accounts/{account_id}/courses
//
// Example:
// const query = {
//   course[name]
//   course[course_code]
//   course[start_at]
//   course[end_at]
//   course[license]
//   course[is_public]
//   course[is_public_to_auth_users]
//   course[public_syllabus]
//   course[public_syllabus_to_auth]
//   course[public_description]
//   course[allow_student_wiki_edits]
//   course[allow_wiki_comments]
//   course[allow_student_forum_attachments]
//   course[open_enrollment]
//   course[self_enrollment]
//   course[restrict_enrollments_to_course_dates]
//   course[term_id]
//   course[sis_course_id]
//   course[integration_id]
//   course[hide_final_grades]
//   course[apply_assignment_group_weights]
//   course[time_zone]
//   offer
//   enroll_me
//   course[syllabus_body]
//   course[grading_standard_id]
//   course[course_format]
//   enable_sis_reactivation
// }
// return canvasRequest(create_new_course, {account_id}, query);
export const createNewCourse = { type: 'CREATE_NEW_COURSE', method: 'post', key: 'create_new_coursecreate_new_course_account_id', required: ['account_id'] };

// Upload a file
// Upload a file to the course.
// 
// This API endpoint is the first step in uploading a file to a course.
// See the {file:file_uploads.html File Upload Documentation} for details on
// the file upload workflow.
// 
// Only those with the "Manage Files" permission on a course can upload files
// to the course. By default, this is Teachers, TAs and Designers.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/files
//
// Example:
// return canvasRequest(courses_upload_file, {course_id});
export const coursesUploadFile = { type: 'COURSES_UPLOAD_FILE', method: 'post', key: 'courses_upload_filecourses_upload_file_course_id', required: ['course_id'] };

// List students
// Returns the list of students enrolled in this course.
// 
// DEPRECATED: Please use the {api:CoursesController#users course users} endpoint
// and pass "student" as the enrollment_type.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/students
//
// Example:
// return canvasRequest(list_students, {course_id});
export const listStudents = { type: 'LIST_STUDENTS', method: 'get', key: 'list_studentslist_students_course_id', required: ['course_id'] };

// List users in course
// Returns the list of users in this course. And optionally the user's enrollments in the course.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/users
//
// Example:
// const query = {
//   search_term
//   enrollment_type
//   enrollment_role
//   enrollment_role_id
//   include
//   user_id
//   user_ids
//   enrollment_state
// }
// return canvasRequest(list_users_in_course_users, {course_id}, query);
export const listUsersInCourseUsers = { type: 'LIST_USERS_IN_COURSE_USERS', method: 'get', key: 'list_users_in_course_userslist_users_in_course_users_course_id', required: ['course_id'] };

// List users in course
// Returns the list of users in this course. And optionally the user's enrollments in the course.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/search_users
//
// Example:
// const query = {
//   search_term
//   enrollment_type
//   enrollment_role
//   enrollment_role_id
//   include
//   user_id
//   user_ids
//   enrollment_state
// }
// return canvasRequest(list_users_in_course_search_users, {course_id}, query);
export const listUsersInCourseSearchUsers = { type: 'LIST_USERS_IN_COURSE_SEARCH_USERS', method: 'get', key: 'list_users_in_course_search_userslist_users_in_course_search_users_course_id', required: ['course_id'] };

// List recently logged in students
// Returns the list of users in this course, ordered by how recently they have
// logged in. The records include the 'last_login' field which contains
// a timestamp of the last time that user logged into canvas.  The querying
// user must have the 'View usage reports' permission.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/recent_students
//
// Example:
// return canvasRequest(list_recently_logged_in_students, {course_id});
export const listRecentlyLoggedInStudents = { type: 'LIST_RECENTLY_LOGGED_IN_STUDENTS', method: 'get', key: 'list_recently_logged_in_studentslist_recently_logged_in_students_course_id', required: ['course_id'] };

// Get single user
// Return information on a single user.
// 
// Accepts the same include[] parameters as the :users: action, and returns a
// single user with the same fields as that action.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/users/{id}
//
// Example:
// return canvasRequest(get_single_user, {course_id, id});
export const getSingleUser = { type: 'GET_SINGLE_USER', method: 'get', key: 'get_single_userget_single_user_{course_id}_{id}', required: ['course_id', 'id'] };

// Preview processed html
// Preview html content processed for this course
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/preview_html
//
// Example:
// const query = {
//   html
// }
// return canvasRequest(courses_preview_processed_html, {course_id}, query);
export const coursesPreviewProcessedHtml = { type: 'COURSES_PREVIEW_PROCESSED_HTML', method: 'post', key: 'courses_preview_processed_htmlcourses_preview_processed_html_course_id', required: ['course_id'] };

// Course activity stream
// Returns the current user's course-specific activity stream, paginated.
// 
// For full documentation, see the API documentation for the user activity
// stream, in the user api.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/activity_stream
//
// Example:
// return canvasRequest(course_activity_stream, {course_id});
export const courseActivityStream = { type: 'COURSE_ACTIVITY_STREAM', method: 'get', key: 'course_activity_streamcourse_activity_stream_course_id', required: ['course_id'] };

// Course activity stream summary
// Returns a summary of the current user's course-specific activity stream.
// 
// For full documentation, see the API documentation for the user activity
// stream summary, in the user api.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/activity_stream/summary
//
// Example:
// return canvasRequest(course_activity_stream_summary, {course_id});
export const courseActivityStreamSummary = { type: 'COURSE_ACTIVITY_STREAM_SUMMARY', method: 'get', key: 'course_activity_stream_summarycourse_activity_stream_summary_course_id', required: ['course_id'] };

// Course TODO items
// Returns the current user's course-specific todo items.
// 
// For full documentation, see the API documentation for the user todo items, in the user api.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/todo
//
// Example:
// return canvasRequest(course_todo_items, {course_id});
export const courseTodoItems = { type: 'COURSE_TODO_ITEMS', method: 'get', key: 'course_todo_itemscourse_todo_items_course_id', required: ['course_id'] };

// Conclude a course
// Delete or conclude an existing course
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{id}
//
// Example:
// const query = {
//   event (required)
// }
// return canvasRequest(conclude_course, {id}, query);
export const concludeCourse = { type: 'CONCLUDE_COURSE', method: 'delete', key: 'conclude_courseconclude_course_id', required: ['id'] };

// Get course settings
// Returns some of a course's settings.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/settings
//
// Example:
// return canvasRequest(get_course_settings, {course_id});
export const getCourseSettings = { type: 'GET_COURSE_SETTINGS', method: 'get', key: 'get_course_settingsget_course_settings_course_id', required: ['course_id'] };

// Update course settings
// Can update the following course settings:
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/settings
//
// Example:
// const query = {
//   allow_student_discussion_topics
//   allow_student_forum_attachments
//   allow_student_discussion_editing
//   allow_student_organized_groups
//   hide_final_grades
//   hide_distribution_graphs
//   lock_all_announcements
//   restrict_student_past_view
//   restrict_student_future_view
//   show_announcements_on_home_page
//   home_page_announcement_limit
// }
// return canvasRequest(update_course_settings, {course_id}, query);
export const updateCourseSettings = { type: 'UPDATE_COURSE_SETTINGS', method: 'put', key: 'update_course_settingsupdate_course_settings_course_id', required: ['course_id'] };

// Get a single course
// Return information on a single course.
// 
// Accepts the same include[] parameters as the list action plus:
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_single_course_courses, {id}, query);
export const getSingleCourseCourses = { type: 'GET_SINGLE_COURSE_COURSES', method: 'get', key: 'get_single_course_coursesget_single_course_courses_id', required: ['id'] };

// Get a single course
// Return information on a single course.
// 
// Accepts the same include[] parameters as the list action plus:
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: accounts/{account_id}/courses/{id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_single_course_accounts, {account_id, id}, query);
export const getSingleCourseAccounts = { type: 'GET_SINGLE_COURSE_ACCOUNTS', method: 'get', key: 'get_single_course_accountsget_single_course_accounts_{account_id}_{id}', required: ['account_id', 'id'] };

// Update a course
// Update an existing course.
// 
// Arguments are the same as Courses#create, with a few exceptions (enroll_me).
// 
// If a user has content management rights, but not full course editing rights, the only attribute
// editable through this endpoint will be "syllabus_body"
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{id}
//
// Example:
// const query = {
//   course[account_id]
//   course[name]
//   course[course_code]
//   course[start_at]
//   course[end_at]
//   course[license]
//   course[is_public]
//   course[is_public_to_auth_users]
//   course[public_syllabus]
//   course[public_syllabus_to_auth]
//   course[public_description]
//   course[allow_student_wiki_edits]
//   course[allow_wiki_comments]
//   course[allow_student_forum_attachments]
//   course[open_enrollment]
//   course[self_enrollment]
//   course[restrict_enrollments_to_course_dates]
//   course[term_id]
//   course[sis_course_id]
//   course[integration_id]
//   course[hide_final_grades]
//   course[time_zone]
//   course[apply_assignment_group_weights]
//   course[storage_quota_mb]
//   offer
//   course[event]
//   course[syllabus_body]
//   course[grading_standard_id]
//   course[course_format]
//   course[image_id]
//   course[image_url]
//   course[remove_image]
// }
// return canvasRequest(update_course, {id}, query);
export const updateCourse = { type: 'UPDATE_COURSE', method: 'put', key: 'update_courseupdate_course_id', required: ['id'] };

// Update courses
// Update multiple courses in an account.  Operates asynchronously; use the {api:ProgressController#show progress endpoint}
// to query the status of an operation.
// 
// The action to take on each course.  Must be one of 'offer', 'conclude', 'delete', or 'undelete'.
//   * 'offer' makes a course visible to students. This action is also called "publish" on the web site.
//   * 'conclude' prevents future enrollments and makes a course read-only for all participants. The course still appears
//     in prior-enrollment lists.
//   * 'delete' completely removes the course from the web site (including course menus and prior-enrollment lists).
//     All enrollments are deleted. Course content may be physically deleted at a future date.
//   * 'undelete' attempts to recover a course that has been deleted. (Recovery is not guaranteed; please conclude
//     rather than delete a course if there is any possibility the course will be used again.) The recovered course
//     will be unpublished. Deleted enrollments will not be recovered.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: accounts/{account_id}/courses
//
// Example:
// const query = {
//   course_ids (required)
//   event (required)
// }
// return canvasRequest(update_courses, {account_id}, query);
export const updateCourses = { type: 'UPDATE_COURSES', method: 'put', key: 'update_coursesupdate_courses_account_id', required: ['account_id'] };

// Reset a course
// Deletes the current course, and creates a new equivalent course with
// no content, but all sections and users moved over.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/reset_content
//
// Example:
// return canvasRequest(reset_course, {course_id});
export const resetCourse = { type: 'RESET_COURSE', method: 'post', key: 'reset_coursereset_course_course_id', required: ['course_id'] };

// Get effective due dates
// For each assignment in the course, returns each assigned student's ID
// and their corresponding due date along with some Multiple Grading Periods
// data. Returns a collection with keys representing assignment IDs and values
// as a collection containing keys representing student IDs and values representing
// the student's effective due_at, the grading_period_id of which the due_at falls
// in, and whether or not the grading period is closed (in_closed_grading_period)
// 
// The list of assignment IDs for which effective student due dates are
// requested. If not provided, all assignments in the course will be used.
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/effective_due_dates
//
// Example:
// const query = {
//   assignment_ids
// }
// return canvasRequest(get_effective_due_dates, {course_id}, query);
export const getEffectiveDueDates = { type: 'GET_EFFECTIVE_DUE_DATES', method: 'get', key: 'get_effective_due_datesget_effective_due_dates_course_id', required: ['course_id'] };

// Permissions
// Returns permission information for provided course & current_user
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/permissions
//
// Example:
// const query = {
//   permissions
// }
// return canvasRequest(permissions, {course_id}, query);
export const permissions = { type: 'PERMISSIONS', method: 'get', key: 'permissionspermissions_course_id', required: ['course_id'] };

// Get course copy status
// DEPRECATED: Please use the {api:ContentMigrationsController#create Content Migrations API}
// 
// Retrieve the status of a course copy
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/course_copy/{id}
//
// Example:
// return canvasRequest(get_course_copy_status, {course_id, id});
export const getCourseCopyStatus = { type: 'GET_COURSE_COPY_STATUS', method: 'get', key: 'get_course_copy_statusget_course_copy_status_{course_id}_{id}', required: ['course_id', 'id'] };

// Copy course content
// DEPRECATED: Please use the {api:ContentMigrationsController#create Content Migrations API}
// 
// Copies content from one course into another. The default is to copy all course
// content. You can control specific types to copy by using either the 'except' option
// or the 'only' option.
// 
// The response is the same as the course copy status endpoint
//
// API Docs: https://canvas.instructure.com/doc/api/courses.html
// API Url: courses/{course_id}/course_copy
//
// Example:
// const query = {
//   source_course
//   except
//   only
// }
// return canvasRequest(copy_course_content, {course_id}, query);
export const copyCourseContent = { type: 'COPY_COURSE_CONTENT', method: 'post', key: 'copy_course_contentcopy_course_content_course_id', required: ['course_id'] };