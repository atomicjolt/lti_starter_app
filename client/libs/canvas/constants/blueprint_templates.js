//
// Blueprint Templates
//
// Get blueprint information
// Using 'default' as the template_id should suffice for the current implmentation (as there should be only one template per course).
// However, using specific template ids may become necessary in the future
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}
//
// Example:
// return canvasRequest(get_blueprint_information, {course_id, template_id});
export const getBlueprintInformation = { type: 'GET_BLUEPRINT_INFORMATION', method: 'get', key: 'get_blueprint_informationget_blueprint_information_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Get associated course information
// Returns a list of courses that are configured to receive updates from this blueprint
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/associated_courses
//
// Example:
// return canvasRequest(get_associated_course_information, {course_id, template_id});
export const getAssociatedCourseInformation = { type: 'GET_ASSOCIATED_COURSE_INFORMATION', method: 'get', key: 'get_associated_course_informationget_associated_course_information_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Update associated courses
// Send a list of course ids to add or remove new associations for the template.
// Cannot add courses that do not belong to the blueprint course's account. Also cannot add
// other blueprint courses or courses that already have an association with another blueprint course.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/update_associations
//
// Example:
// const query = {
//   course_ids_to_add
//   course_ids_to_remove
// }
// return canvasRequest(update_associated_courses, {course_id, template_id}, query);
export const updateAssociatedCourses = { type: 'UPDATE_ASSOCIATED_COURSES', method: 'put', key: 'update_associated_coursesupdate_associated_courses_{course_id}_{template_id}', required: ['course_id', 'template_id'] };