//
// SIS Integration
//
// Retrieve assignments enabled for grade export to SIS
// Retrieve a list of published assignments flagged as "post_to_sis". Assignment group and section information are
// included for convenience.
// 
// Each section includes course information for the origin course and the cross-listed course, if applicable. The
// `origin_course` is the course to which the section belongs or the course from which the section was cross-listed.
// Generally, the `origin_course` should be preferred when performing integration work. The `xlist_course` is provided
// for consistency and is only present when the section has been cross-listed.
// 
// The `override` is only provided if the Differentiated Assignments course feature is turned on and the assignment
// has an override for that section. When there is an override for the assignment the override object's keys/values can
// be merged with the top level assignment object to create a view of the assignment object specific to that section.
//
// API Docs: https://canvas.instructure.com/doc/api/sis_integration.html
// API Url: /sis/accounts/{account_id}/assignments
//
// Example:
// const query = {
//   course_id
//   starts_before
//   ends_after
//   include
// }
// return canvasRequest(retrieve_assignments_enabled_for_grade_export_to_sis_accounts, {account_id}, query);
export const retrieveAssignmentsEnabledForGradeExportToSisAccounts = { type: 'RETRIEVE_ASSIGNMENTS_ENABLED_FOR_GRADE_EXPORT_TO_SIS_ACCOUNTS', method: 'get', key: 'retrieve_assignments_enabled_for_grade_export_to_sis_accountsretrieve_assignments_enabled_for_grade_export_to_sis_accounts_account_id', required: ['account_id'] };

// Retrieve assignments enabled for grade export to SIS
// Retrieve a list of published assignments flagged as "post_to_sis". Assignment group and section information are
// included for convenience.
// 
// Each section includes course information for the origin course and the cross-listed course, if applicable. The
// `origin_course` is the course to which the section belongs or the course from which the section was cross-listed.
// Generally, the `origin_course` should be preferred when performing integration work. The `xlist_course` is provided
// for consistency and is only present when the section has been cross-listed.
// 
// The `override` is only provided if the Differentiated Assignments course feature is turned on and the assignment
// has an override for that section. When there is an override for the assignment the override object's keys/values can
// be merged with the top level assignment object to create a view of the assignment object specific to that section.
//
// API Docs: https://canvas.instructure.com/doc/api/sis_integration.html
// API Url: /sis/courses/{course_id}/assignments
//
// Example:
// const query = {
//   account_id
//   starts_before
//   ends_after
//   include
// }
// return canvasRequest(retrieve_assignments_enabled_for_grade_export_to_sis_courses, {course_id}, query);
export const retrieveAssignmentsEnabledForGradeExportToSisCourses = { type: 'RETRIEVE_ASSIGNMENTS_ENABLED_FOR_GRADE_EXPORT_TO_SIS_COURSES', method: 'get', key: 'retrieve_assignments_enabled_for_grade_export_to_sis_coursesretrieve_assignments_enabled_for_grade_export_to_sis_courses_course_id', required: ['course_id'] };

// Disable assignments currently enabled for grade export to SIS
// Disable all assignments flagged as "post_to_sis", with the option of making it
// specific to a grading period, in a course.
// 
// On success, the response will be 204 No Content with an empty body.
// 
// On failure, the response will be 400 Bad Request with a body of a specific
// message.
// 
// For disabling assignments in a specific grading period
//
// API Docs: https://canvas.instructure.com/doc/api/sis_integration.html
// API Url: /sis/courses/{course_id}/disable_post_to_sis
//
// Example:
// const query = {
//   grading_period_id
// }
// return canvasRequest(disable_assignments_currently_enabled_for_grade_export_to_sis, {course_id}, query);
export const disableAssignmentsCurrentlyEnabledForGradeExportToSis = { type: 'DISABLE_ASSIGNMENTS_CURRENTLY_ENABLED_FOR_GRADE_EXPORT_TO_SIS', method: 'put', key: 'disable_assignments_currently_enabled_for_grade_export_to_sisdisable_assignments_currently_enabled_for_grade_export_to_sis_course_id', required: ['course_id'] };