//
// ePub Exports
//
// List courses with their latest ePub export
// Lists all courses a user is actively participating in,
// and the latest ePub export associated with the user & course.
//
// API Docs: https://canvas.instructure.com/doc/api/e_pub_exports.html
// API Url: epub_exports
//
// Example:
// return canvasRequest(list_courses_with_their_latest_epub_export, {});
export const listCoursesWithTheirLatestEpubExport = { type: 'LIST_COURSES_WITH_THEIR_LATEST_EPUB_EXPORT', method: 'get', key: 'list_courses_with_their_latest_epub_export', required: [] };

// Create ePub Export
// Begin an ePub export for a course.
// 
// You can use the {api:ProgressController#show Progress API} to track the
// progress of the export. The export's progress is linked to with the
// _progress_url_ value.
// 
// When the export completes, use the {api:EpubExportsController#show Show content export} endpoint
// to retrieve a download URL for the exported content.
//
// API Docs: https://canvas.instructure.com/doc/api/e_pub_exports.html
// API Url: courses/{course_id}/epub_exports
//
// Example:
// return canvasRequest(create_epub_export, {course_id});
export const createEpubExport = { type: 'CREATE_EPUB_EXPORT', method: 'post', key: 'create_epub_exportcreate_epub_export_course_id', required: ['course_id'] };

// Show ePub export
// Get information about a single ePub export.
//
// API Docs: https://canvas.instructure.com/doc/api/e_pub_exports.html
// API Url: courses/{course_id}/epub_exports/{id}
//
// Example:
// return canvasRequest(show_epub_export, {course_id, id});
export const showEpubExport = { type: 'SHOW_EPUB_EXPORT', method: 'get', key: 'show_epub_exportshow_epub_export_{course_id}_{id}', required: ['course_id', 'id'] };