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

// Begin a migration to push to associated courses
// Begins a migration to push recently updated content to all associated courses.
// Only one migration can be running at a time.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations
//
// Example:
// const query = {
//   comment
// }
// return canvasRequest(begin_migration_to_push_to_associated_courses, {course_id, template_id}, query);
export const beginMigrationToPushToAssociatedCourses = { type: 'BEGIN_MIGRATION_TO_PUSH_TO_ASSOCIATED_COURSES', method: 'post', key: 'begin_migration_to_push_to_associated_coursesbegin_migration_to_push_to_associated_courses_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// List blueprint migrations
// Shows migrations for the template, starting with the most recent
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations
//
// Example:
// return canvasRequest(list_blueprint_migrations, {course_id, template_id});
export const listBlueprintMigrations = { type: 'LIST_BLUEPRINT_MIGRATIONS', method: 'get', key: 'list_blueprint_migrationslist_blueprint_migrations_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Show a blueprint migration
// Shows the status of a migration
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations/{id}
//
// Example:
// return canvasRequest(show_blueprint_migration, {course_id, template_id, id});
export const showBlueprintMigration = { type: 'SHOW_BLUEPRINT_MIGRATION', method: 'get', key: 'show_blueprint_migrationshow_blueprint_migration_{course_id}_{template_id}_{id}', required: ['course_id', 'template_id', 'id'] };

// Set or remove restrictions on a blueprint course object
// If a blueprint course object is restricted, editing will be limited for copies in associated courses.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/restrict_item
//
// Example:
// const query = {
//   content_type
//   content_id
//   restricted
//   restrictions
// }
// return canvasRequest(set_or_remove_restrictions_on_blueprint_course_object, {course_id, template_id}, query);
export const setOrRemoveRestrictionsOnBlueprintCourseObject = { type: 'SET_OR_REMOVE_RESTRICTIONS_ON_BLUEPRINT_COURSE_OBJECT', method: 'put', key: 'set_or_remove_restrictions_on_blueprint_course_objectset_or_remove_restrictions_on_blueprint_course_object_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Get migration details
// Show the changes that were propagated in a blueprint migration. This endpoint can be called on a
// blueprint course or an associated course; when called on an associated course, the exceptions
// field will only include records for that course (and not other courses associated with the blueprint).
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations/{id}/details
//
// Example:
// return canvasRequest(get_migration_details, {course_id, template_id, id});
export const getMigrationDetails = { type: 'GET_MIGRATION_DETAILS', method: 'get', key: 'get_migration_detailsget_migration_details_{course_id}_{template_id}_{id}', required: ['course_id', 'template_id', 'id'] };

// Get unsynced changes
// Retrieve a list of learning objects that have changed since the last blueprint sync operation.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_templates.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/unsynced_changes
//
// Example:
// return canvasRequest(get_unsynced_changes, {course_id, template_id});
export const getUnsyncedChanges = { type: 'GET_UNSYNCED_CHANGES', method: 'get', key: 'get_unsynced_changesget_unsynced_changes_{course_id}_{template_id}', required: ['course_id', 'template_id'] };