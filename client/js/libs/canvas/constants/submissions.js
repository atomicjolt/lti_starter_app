//
// Submissions
//
// Submit an assignment
// Make a submission for an assignment. You must be enrolled as a student in
// the course/section to do this.
// 
// All online turn-in submission types are supported in this API. However,
// there are a few things that are not yet supported:
// 
// * Files can be submitted based on a file ID of a user or group file. However, there is no API yet for listing the user and group files, or uploading new files via the API. A file upload API is coming soon.
// * Media comments can be submitted, however, there is no API yet for creating a media comment to submit.
// * Integration with Google Docs is not yet supported.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions
//
// Example:
// const query = {
//   comment[text_comment]
//   submission[submission_type] (required)
//   submission[body]
//   submission[url]
//   submission[file_ids]
//   submission[media_comment_id]
//   submission[media_comment_type]
// }
// return canvasRequest(submit_assignment_courses, {course_id, assignment_id}, query);
export const submitAssignmentCourses = { type: 'SUBMIT_ASSIGNMENT_COURSES', method: 'post', key: 'submit_assignment_coursessubmit_assignment_courses_{course_id}_{assignment_id}', required: ['course_id', 'assignment_id'] };

// Submit an assignment
// Make a submission for an assignment. You must be enrolled as a student in
// the course/section to do this.
// 
// All online turn-in submission types are supported in this API. However,
// there are a few things that are not yet supported:
// 
// * Files can be submitted based on a file ID of a user or group file. However, there is no API yet for listing the user and group files, or uploading new files via the API. A file upload API is coming soon.
// * Media comments can be submitted, however, there is no API yet for creating a media comment to submit.
// * Integration with Google Docs is not yet supported.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions
//
// Example:
// const query = {
//   comment[text_comment]
//   submission[submission_type] (required)
//   submission[body]
//   submission[url]
//   submission[file_ids]
//   submission[media_comment_id]
//   submission[media_comment_type]
// }
// return canvasRequest(submit_assignment_sections, {section_id, assignment_id}, query);
export const submitAssignmentSections = { type: 'SUBMIT_ASSIGNMENT_SECTIONS', method: 'post', key: 'submit_assignment_sectionssubmit_assignment_sections_{section_id}_{assignment_id}', required: ['section_id', 'assignment_id'] };

// List assignment submissions
// Get all existing submissions for an assignment.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions
//
// Example:
// const query = {
//   include
//   grouped
// }
// return canvasRequest(list_assignment_submissions_courses, {course_id, assignment_id}, query);
export const listAssignmentSubmissionsCourses = { type: 'LIST_ASSIGNMENT_SUBMISSIONS_COURSES', method: 'get', key: 'list_assignment_submissions_courseslist_assignment_submissions_courses_{course_id}_{assignment_id}', required: ['course_id', 'assignment_id'] };

// List assignment submissions
// Get all existing submissions for an assignment.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions
//
// Example:
// const query = {
//   include
//   grouped
// }
// return canvasRequest(list_assignment_submissions_sections, {section_id, assignment_id}, query);
export const listAssignmentSubmissionsSections = { type: 'LIST_ASSIGNMENT_SUBMISSIONS_SECTIONS', method: 'get', key: 'list_assignment_submissions_sectionslist_assignment_submissions_sections_{section_id}_{assignment_id}', required: ['section_id', 'assignment_id'] };

// List submissions for multiple assignments
// Get all existing submissions for a given set of students and assignments.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/students/submissions
//
// Example:
// const query = {
//   student_ids
//   assignment_ids
//   grouped
//   grading_period_id
//   order
//   order_direction
//   include
// }
// return canvasRequest(list_submissions_for_multiple_assignments_courses, {course_id}, query);
export const listSubmissionsForMultipleAssignmentsCourses = { type: 'LIST_SUBMISSIONS_FOR_MULTIPLE_ASSIGNMENTS_COURSES', method: 'get', key: 'list_submissions_for_multiple_assignments_courseslist_submissions_for_multiple_assignments_courses_course_id', required: ['course_id'] };

// List submissions for multiple assignments
// Get all existing submissions for a given set of students and assignments.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/students/submissions
//
// Example:
// const query = {
//   student_ids
//   assignment_ids
//   grouped
//   grading_period_id
//   order
//   order_direction
//   include
// }
// return canvasRequest(list_submissions_for_multiple_assignments_sections, {section_id}, query);
export const listSubmissionsForMultipleAssignmentsSections = { type: 'LIST_SUBMISSIONS_FOR_MULTIPLE_ASSIGNMENTS_SECTIONS', method: 'get', key: 'list_submissions_for_multiple_assignments_sectionslist_submissions_for_multiple_assignments_sections_section_id', required: ['section_id'] };

// Get a single submission
// Get a single submission, based on user id.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions/{user_id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_single_submission_courses, {course_id, assignment_id, user_id}, query);
export const getSingleSubmissionCourses = { type: 'GET_SINGLE_SUBMISSION_COURSES', method: 'get', key: 'get_single_submission_coursesget_single_submission_courses_{course_id}_{assignment_id}_{user_id}', required: ['course_id', 'assignment_id', 'user_id'] };

// Get a single submission
// Get a single submission, based on user id.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions/{user_id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_single_submission_sections, {section_id, assignment_id, user_id}, query);
export const getSingleSubmissionSections = { type: 'GET_SINGLE_SUBMISSION_SECTIONS', method: 'get', key: 'get_single_submission_sectionsget_single_submission_sections_{section_id}_{assignment_id}_{user_id}', required: ['section_id', 'assignment_id', 'user_id'] };

// Upload a file
// Upload a file to a submission.
// 
// This API endpoint is the first step in uploading a file to a submission as a student.
// See the {file:file_uploads.html File Upload Documentation} for details on the file upload workflow.
// 
// The final step of the file upload workflow will return the attachment data,
// including the new file id. The caller can then POST to submit the
// +online_upload+ assignment with these file ids.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions/{user_id}/files
//
// Example:
// return canvasRequest(upload_file_courses, {course_id, assignment_id, user_id});
export const uploadFileCourses = { type: 'UPLOAD_FILE_COURSES', method: 'post', key: 'upload_file_coursesupload_file_courses_{course_id}_{assignment_id}_{user_id}', required: ['course_id', 'assignment_id', 'user_id'] };

// Upload a file
// Upload a file to a submission.
// 
// This API endpoint is the first step in uploading a file to a submission as a student.
// See the {file:file_uploads.html File Upload Documentation} for details on the file upload workflow.
// 
// The final step of the file upload workflow will return the attachment data,
// including the new file id. The caller can then POST to submit the
// +online_upload+ assignment with these file ids.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions/{user_id}/files
//
// Example:
// return canvasRequest(upload_file_sections, {section_id, assignment_id, user_id});
export const uploadFileSections = { type: 'UPLOAD_FILE_SECTIONS', method: 'post', key: 'upload_file_sectionsupload_file_sections_{section_id}_{assignment_id}_{user_id}', required: ['section_id', 'assignment_id', 'user_id'] };

// Grade or comment on a submission
// Comment on and/or update the grading for a student's assignment submission.
// If any submission or rubric_assessment arguments are provided, the user
// must have permission to manage grades in the appropriate context (course or
// section).
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions/{user_id}
//
// Example:
// const query = {
//   comment[text_comment]
//   comment[group_comment]
//   comment[media_comment_id]
//   comment[media_comment_type]
//   comment[file_ids]
//   include[visibility]
//   submission[posted_grade]
//   submission[excuse]
//   rubric_assessment
// }
// return canvasRequest(grade_or_comment_on_submission_courses, {course_id, assignment_id, user_id}, query);
export const gradeOrCommentOnSubmissionCourses = { type: 'GRADE_OR_COMMENT_ON_SUBMISSION_COURSES', method: 'put', key: 'grade_or_comment_on_submission_coursesgrade_or_comment_on_submission_courses_{course_id}_{assignment_id}_{user_id}', required: ['course_id', 'assignment_id', 'user_id'] };

// Grade or comment on a submission
// Comment on and/or update the grading for a student's assignment submission.
// If any submission or rubric_assessment arguments are provided, the user
// must have permission to manage grades in the appropriate context (course or
// section).
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions/{user_id}
//
// Example:
// const query = {
//   comment[text_comment]
//   comment[group_comment]
//   comment[media_comment_id]
//   comment[media_comment_type]
//   comment[file_ids]
//   include[visibility]
//   submission[posted_grade]
//   submission[excuse]
//   rubric_assessment
// }
// return canvasRequest(grade_or_comment_on_submission_sections, {section_id, assignment_id, user_id}, query);
export const gradeOrCommentOnSubmissionSections = { type: 'GRADE_OR_COMMENT_ON_SUBMISSION_SECTIONS', method: 'put', key: 'grade_or_comment_on_submission_sectionsgrade_or_comment_on_submission_sections_{section_id}_{assignment_id}_{user_id}', required: ['section_id', 'assignment_id', 'user_id'] };

// List gradeable students
// List students eligible to submit the assignment. The caller must have permission to view grades.
// 
// Section-limited instructors will only see students in their own sections.
// 
// returns [UserDisplay]
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/gradeable_students
//
// Example:
// return canvasRequest(list_gradeable_students, {course_id, assignment_id});
export const listGradeableStudents = { type: 'LIST_GRADEABLE_STUDENTS', method: 'get', key: 'list_gradeable_studentslist_gradeable_students_{course_id}_{assignment_id}', required: ['course_id', 'assignment_id'] };

// List multiple assignments gradeable students
// List students eligible to submit a list of assignments. The caller must have
// permission to view grades for the requested course.
// 
// Section-limited instructors will only see students in their own sections.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/gradeable_students
//
// Example:
// const query = {
//   assignment_ids
// }
// return canvasRequest(list_multiple_assignments_gradeable_students, {course_id}, query);
export const listMultipleAssignmentsGradeableStudents = { type: 'LIST_MULTIPLE_ASSIGNMENTS_GRADEABLE_STUDENTS', method: 'get', key: 'list_multiple_assignments_gradeable_studentslist_multiple_assignments_gradeable_students_course_id', required: ['course_id'] };

// Grade or comment on multiple submissions
// Update the grading and comments on multiple student's assignment
// submissions in an asynchronous job.
// 
// The user must have permission to manage grades in the appropriate context
// (course or section).
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/submissions/update_grades
//
// Example:
// const query = {
//   grade_data[<student_id>][posted_grade]
//   grade_data[<student_id>][excuse]
//   grade_data[<student_id>][rubric_assessment]
//   grade_data[<student_id>][text_comment]
//   grade_data[<student_id>][group_comment]
//   grade_data[<student_id>][media_comment_id]
//   grade_data[<student_id>][media_comment_type]
//   grade_data[<student_id>][file_ids]
// }
// return canvasRequest(grade_or_comment_on_multiple_submissions_courses_submissions, {course_id}, query);
export const gradeOrCommentOnMultipleSubmissionsCoursesSubmissions = { type: 'GRADE_OR_COMMENT_ON_MULTIPLE_SUBMISSIONS_COURSES_SUBMISSIONS', method: 'post', key: 'grade_or_comment_on_multiple_submissions_courses_submissionsgrade_or_comment_on_multiple_submissions_courses_submissions_course_id', required: ['course_id'] };

// Grade or comment on multiple submissions
// Update the grading and comments on multiple student's assignment
// submissions in an asynchronous job.
// 
// The user must have permission to manage grades in the appropriate context
// (course or section).
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions/update_grades
//
// Example:
// const query = {
//   grade_data[<student_id>][posted_grade]
//   grade_data[<student_id>][excuse]
//   grade_data[<student_id>][rubric_assessment]
//   grade_data[<student_id>][text_comment]
//   grade_data[<student_id>][group_comment]
//   grade_data[<student_id>][media_comment_id]
//   grade_data[<student_id>][media_comment_type]
//   grade_data[<student_id>][file_ids]
// }
// return canvasRequest(grade_or_comment_on_multiple_submissions_courses_assignments, {course_id, assignment_id}, query);
export const gradeOrCommentOnMultipleSubmissionsCoursesAssignments = { type: 'GRADE_OR_COMMENT_ON_MULTIPLE_SUBMISSIONS_COURSES_ASSIGNMENTS', method: 'post', key: 'grade_or_comment_on_multiple_submissions_courses_assignmentsgrade_or_comment_on_multiple_submissions_courses_assignments_{course_id}_{assignment_id}', required: ['course_id', 'assignment_id'] };

// Grade or comment on multiple submissions
// Update the grading and comments on multiple student's assignment
// submissions in an asynchronous job.
// 
// The user must have permission to manage grades in the appropriate context
// (course or section).
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/submissions/update_grades
//
// Example:
// const query = {
//   grade_data[<student_id>][posted_grade]
//   grade_data[<student_id>][excuse]
//   grade_data[<student_id>][rubric_assessment]
//   grade_data[<student_id>][text_comment]
//   grade_data[<student_id>][group_comment]
//   grade_data[<student_id>][media_comment_id]
//   grade_data[<student_id>][media_comment_type]
//   grade_data[<student_id>][file_ids]
// }
// return canvasRequest(grade_or_comment_on_multiple_submissions_sections_submissions, {section_id}, query);
export const gradeOrCommentOnMultipleSubmissionsSectionsSubmissions = { type: 'GRADE_OR_COMMENT_ON_MULTIPLE_SUBMISSIONS_SECTIONS_SUBMISSIONS', method: 'post', key: 'grade_or_comment_on_multiple_submissions_sections_submissionsgrade_or_comment_on_multiple_submissions_sections_submissions_section_id', required: ['section_id'] };

// Grade or comment on multiple submissions
// Update the grading and comments on multiple student's assignment
// submissions in an asynchronous job.
// 
// The user must have permission to manage grades in the appropriate context
// (course or section).
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions/update_grades
//
// Example:
// const query = {
//   grade_data[<student_id>][posted_grade]
//   grade_data[<student_id>][excuse]
//   grade_data[<student_id>][rubric_assessment]
//   grade_data[<student_id>][text_comment]
//   grade_data[<student_id>][group_comment]
//   grade_data[<student_id>][media_comment_id]
//   grade_data[<student_id>][media_comment_type]
//   grade_data[<student_id>][file_ids]
// }
// return canvasRequest(grade_or_comment_on_multiple_submissions_sections_assignments, {section_id, assignment_id}, query);
export const gradeOrCommentOnMultipleSubmissionsSectionsAssignments = { type: 'GRADE_OR_COMMENT_ON_MULTIPLE_SUBMISSIONS_SECTIONS_ASSIGNMENTS', method: 'post', key: 'grade_or_comment_on_multiple_submissions_sections_assignmentsgrade_or_comment_on_multiple_submissions_sections_assignments_{section_id}_{assignment_id}', required: ['section_id', 'assignment_id'] };

// Mark submission as read
// No request fields are necessary.
// 
// On success, the response will be 204 No Content with an empty body.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions/{user_id}/read
//
// Example:
// return canvasRequest(mark_submission_as_read_courses, {course_id, assignment_id, user_id});
export const markSubmissionAsReadCourses = { type: 'MARK_SUBMISSION_AS_READ_COURSES', method: 'put', key: 'mark_submission_as_read_coursesmark_submission_as_read_courses_{course_id}_{assignment_id}_{user_id}', required: ['course_id', 'assignment_id', 'user_id'] };

// Mark submission as read
// No request fields are necessary.
// 
// On success, the response will be 204 No Content with an empty body.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions/{user_id}/read
//
// Example:
// return canvasRequest(mark_submission_as_read_sections, {section_id, assignment_id, user_id});
export const markSubmissionAsReadSections = { type: 'MARK_SUBMISSION_AS_READ_SECTIONS', method: 'put', key: 'mark_submission_as_read_sectionsmark_submission_as_read_sections_{section_id}_{assignment_id}_{user_id}', required: ['section_id', 'assignment_id', 'user_id'] };

// Mark submission as unread
// No request fields are necessary.
// 
// On success, the response will be 204 No Content with an empty body.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: courses/{course_id}/assignments/{assignment_id}/submissions/{user_id}/read
//
// Example:
// return canvasRequest(mark_submission_as_unread_courses, {course_id, assignment_id, user_id});
export const markSubmissionAsUnreadCourses = { type: 'MARK_SUBMISSION_AS_UNREAD_COURSES', method: 'delete', key: 'mark_submission_as_unread_coursesmark_submission_as_unread_courses_{course_id}_{assignment_id}_{user_id}', required: ['course_id', 'assignment_id', 'user_id'] };

// Mark submission as unread
// No request fields are necessary.
// 
// On success, the response will be 204 No Content with an empty body.
//
// API Docs: https://canvas.instructure.com/doc/api/submissions.html
// API Url: sections/{section_id}/assignments/{assignment_id}/submissions/{user_id}/read
//
// Example:
// return canvasRequest(mark_submission_as_unread_sections, {section_id, assignment_id, user_id});
export const markSubmissionAsUnreadSections = { type: 'MARK_SUBMISSION_AS_UNREAD_SECTIONS', method: 'delete', key: 'mark_submission_as_unread_sectionsmark_submission_as_unread_sections_{section_id}_{assignment_id}_{user_id}', required: ['section_id', 'assignment_id', 'user_id'] };