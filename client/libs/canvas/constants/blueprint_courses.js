//
// Blueprint Courses
//
// Get blueprint information
// Using 'default' as the template_id should suffice for the current implmentation (as there should be only one template per course).
// However, using specific template ids may become necessary in the future
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}
//
// Example:
// return canvasRequest(get_blueprint_information, {course_id, template_id});
export const getBlueprintInformation = { type: 'GET_BLUEPRINT_INFORMATION', method: 'get', key: 'get_blueprint_informationget_blueprint_information_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Get associated course information
// Returns a list of courses that are configured to receive updates from this blueprint
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
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
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
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
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations
//
// Example:
// const query = {
//   comment
//   send_notification
//   copy_settings
// }
// return canvasRequest(begin_migration_to_push_to_associated_courses, {course_id, template_id}, query);
export const beginMigrationToPushToAssociatedCourses = { type: 'BEGIN_MIGRATION_TO_PUSH_TO_ASSOCIATED_COURSES', method: 'post', key: 'begin_migration_to_push_to_associated_coursesbegin_migration_to_push_to_associated_courses_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Set or remove restrictions on a blueprint course object
// If a blueprint course object is restricted, editing will be limited for copies in associated courses.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
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

// Get unsynced changes
// Retrieve a list of learning objects that have changed since the last blueprint sync operation.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/unsynced_changes
//
// Example:
// return canvasRequest(get_unsynced_changes, {course_id, template_id});
export const getUnsyncedChanges = { type: 'GET_UNSYNCED_CHANGES', method: 'get', key: 'get_unsynced_changesget_unsynced_changes_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// List blueprint migrations
// Shows migrations for the template, starting with the most recent. This endpoint can be called on a
// blueprint course. See also {api:MasterCourses::MasterTemplatesController#imports_index the associated course side}.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations
//
// Example:
// return canvasRequest(list_blueprint_migrations, {course_id, template_id});
export const listBlueprintMigrations = { type: 'LIST_BLUEPRINT_MIGRATIONS', method: 'get', key: 'list_blueprint_migrationslist_blueprint_migrations_{course_id}_{template_id}', required: ['course_id', 'template_id'] };

// Show a blueprint migration
// Shows the status of a migration. This endpoint can be called on a blueprint course. See also
// {api:MasterCourses::MasterTemplatesController#imports_show the associated course side}.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations/{id}
//
// Example:
// return canvasRequest(show_blueprint_migration, {course_id, template_id, id});
export const showBlueprintMigration = { type: 'SHOW_BLUEPRINT_MIGRATION', method: 'get', key: 'show_blueprint_migrationshow_blueprint_migration_{course_id}_{template_id}_{id}', required: ['course_id', 'template_id', 'id'] };

// Get migration details
// Show the changes that were propagated in a blueprint migration. This endpoint can be called on a
// blueprint course. See also {api:MasterCourses::MasterTemplatesController#import_details the associated course side}.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_templates/{template_id}/migrations/{id}/details
//
// Example:
// return canvasRequest(get_migration_details, {course_id, template_id, id});
export const getMigrationDetails = { type: 'GET_MIGRATION_DETAILS', method: 'get', key: 'get_migration_detailsget_migration_details_{course_id}_{template_id}_{id}', required: ['course_id', 'template_id', 'id'] };

// List blueprint imports
// Shows migrations imported into a course associated with a blueprint, starting with the most recent. See also
// {api:MasterCourses::MasterTemplatesController#migrations_index the blueprint course side}.
// 
// Use 'default' as the subscription_id to use the currently active blueprint subscription.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_subscriptions/{subscription_id}/migrations
//
// Example:
// return canvasRequest(list_blueprint_imports, {course_id, subscription_id});
export const listBlueprintImports = { type: 'LIST_BLUEPRINT_IMPORTS', method: 'get', key: 'list_blueprint_importslist_blueprint_imports_{course_id}_{subscription_id}', required: ['course_id', 'subscription_id'] };

// Show a blueprint import
// Shows the status of an import into a course associated with a blueprint. See also
// {api:MasterCourses::MasterTemplatesController#migrations_show the blueprint course side}.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_subscriptions/{subscription_id}/migrations/{id}
//
// Example:
// return canvasRequest(show_blueprint_import, {course_id, subscription_id, id});
export const showBlueprintImport = { type: 'SHOW_BLUEPRINT_IMPORT', method: 'get', key: 'show_blueprint_importshow_blueprint_import_{course_id}_{subscription_id}_{id}', required: ['course_id', 'subscription_id', 'id'] };

// Get import details
// Show the changes that were propagated to a course associated with a blueprint.  See also
// {api:MasterCourses::MasterTemplatesController#migration_details the blueprint course side}.
//
// API Docs: https://canvas.instructure.com/doc/api/blueprint_courses.html
// API Url: courses/{course_id}/blueprint_subscriptions/{subscription_id}/migrations/{id}/details
//
// Example:
// return canvasRequest(get_import_details, {course_id, subscription_id, id});
export const getImportDetails = { type: 'GET_IMPORT_DETAILS', method: 'get', key: 'get_import_detailsget_import_details_{course_id}_{subscription_id}_{id}', required: ['course_id', 'subscription_id', 'id'] };