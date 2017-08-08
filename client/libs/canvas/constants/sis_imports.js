//
// SIS Imports
//
// Get SIS import list
// Returns the list of SIS imports for an account
// 
// Example:
//   curl 'https://<canvas>/api/v1/accounts/<account_id>/sis_imports' \
//     -H "Authorization: Bearer <token>"
//
// API Docs: https://canvas.instructure.com/doc/api/sis_imports.html
// API Url: accounts/{account_id}/sis_imports
//
// Example:
// const query = {
//   created_since
// }
// return canvasRequest(get_sis_import_list, {account_id}, query);
export const getSisImportList = { type: 'GET_SIS_IMPORT_LIST', method: 'get', key: 'get_sis_import_listget_sis_import_list_account_id', required: ['account_id'] };

// Import SIS data
// Import SIS data into Canvas. Must be on a root account with SIS imports
// enabled.
// 
// For more information on the format that's expected here, please see the
// "SIS CSV" section in the API docs.
//
// API Docs: https://canvas.instructure.com/doc/api/sis_imports.html
// API Url: accounts/{account_id}/sis_imports
//
// Example:
// const query = {
//   import_type
//   attachment
//   extension
//   batch_mode
//   batch_mode_term_id
//   override_sis_stickiness
//   add_sis_stickiness
//   clear_sis_stickiness
//   diffing_data_set_identifier
//   diffing_remaster_data_set
//   change_threshold
// }
// return canvasRequest(import_sis_data, {account_id}, query);
export const importSisData = { type: 'IMPORT_SIS_DATA', method: 'post', key: 'import_sis_dataimport_sis_data_account_id', required: ['account_id'] };

// Get SIS import status
// Get the status of an already created SIS import.
// 
//   Examples:
//     curl 'https://<canvas>/api/v1/accounts/<account_id>/sis_imports/<sis_import_id>' \
//         -H "Authorization: Bearer <token>"
//
// API Docs: https://canvas.instructure.com/doc/api/sis_imports.html
// API Url: accounts/{account_id}/sis_imports/{id}
//
// Example:
// return canvasRequest(get_sis_import_status, {account_id, id});
export const getSisImportStatus = { type: 'GET_SIS_IMPORT_STATUS', method: 'get', key: 'get_sis_import_statusget_sis_import_status_{account_id}_{id}', required: ['account_id', 'id'] };

// Abort SIS import
// Abort a SIS import that has not completed.
//
// API Docs: https://canvas.instructure.com/doc/api/sis_imports.html
// API Url: accounts/{account_id}/sis_imports/{id}/abort
//
// Example:
// return canvasRequest(abort_sis_import, {account_id, id});
export const abortSisImport = { type: 'ABORT_SIS_IMPORT', method: 'put', key: 'abort_sis_importabort_sis_import_{account_id}_{id}', required: ['account_id', 'id'] };

// Abort all pending SIS imports
// Abort already created but not processed or processing SIS imports.
//
// API Docs: https://canvas.instructure.com/doc/api/sis_imports.html
// API Url: accounts/{account_id}/sis_imports/abort_all_pending
//
// Example:
// return canvasRequest(abort_all_pending_sis_imports, {account_id});
export const abortAllPendingSisImports = { type: 'ABORT_ALL_PENDING_SIS_IMPORTS', method: 'put', key: 'abort_all_pending_sis_importsabort_all_pending_sis_imports_account_id', required: ['account_id'] };