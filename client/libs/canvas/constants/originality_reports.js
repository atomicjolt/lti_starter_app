//
// Originality Reports
//
// Create an Originality Report
// Create a new OriginalityReport for the specified file
//
// API Docs: https://canvas.instructure.com/doc/api/originality_reports.html
// API Url: /lti/assignments/{assignment_id}/submissions/{submission_id}/originality_report
//
// Example:
// const query = {
//   originality_report[file_id] (required)
//   originality_report[originality_score] (required)
//   originality_report[originality_report_url]
//   originality_report[originality_report_file_id]
//   originality_report[tool_setting][resource_type_code]
//   originality_report[tool_setting][resource_url]
//   originality_report[workflow_state]
// }
// return canvasRequest(create_originality_report, {assignment_id, submission_id}, query);
export const createOriginalityReport = { type: 'CREATE_ORIGINALITY_REPORT', method: 'post', key: 'create_originality_reportcreate_originality_report_{assignment_id}_{submission_id}', required: ['assignment_id', 'submission_id'] };

// Edit an Originality Report
// Modify an existing originality report
//
// API Docs: https://canvas.instructure.com/doc/api/originality_reports.html
// API Url: /lti/assignments/{assignment_id}/submissions/{submission_id}/originality_report/{id}
//
// Example:
// const query = {
//   originality_report[originality_score]
//   originality_report[originality_report_url]
//   originality_report[originality_report_file_id]
//   originality_report[tool_setting][resource_type_code]
//   originality_report[tool_setting][resource_url]
//   originality_report[workflow_state]
// }
// return canvasRequest(edit_originality_report, {assignment_id, submission_id, id}, query);
export const editOriginalityReport = { type: 'EDIT_ORIGINALITY_REPORT', method: 'put', key: 'edit_originality_reportedit_originality_report_{assignment_id}_{submission_id}_{id}', required: ['assignment_id', 'submission_id', 'id'] };

// Show an Originality Report
// Get a single originality report
//
// API Docs: https://canvas.instructure.com/doc/api/originality_reports.html
// API Url: /lti/assignments/{assignment_id}/submissions/{submission_id}/originality_report/{id}
//
// Example:
// return canvasRequest(show_originality_report, {assignment_id, submission_id, id});
export const showOriginalityReport = { type: 'SHOW_ORIGINALITY_REPORT', method: 'get', key: 'show_originality_reportshow_originality_report_{assignment_id}_{submission_id}_{id}', required: ['assignment_id', 'submission_id', 'id'] };