//
// Enrollment Terms
//
// Create enrollment term
// Create a new enrollment term for the specified account.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollment_terms.html
// API Url: accounts/{account_id}/terms
//
// Example:
// const query = {
//   enrollment_term[name]
//   enrollment_term[start_at]
//   enrollment_term[end_at]
//   enrollment_term[sis_term_id]
//   enrollment_term[overrides][enrollment_type][start_at]
//   enrollment_term[overrides][enrollment_type][end_at]
// }
// return canvasRequest(create_enrollment_term, {account_id}, query);
export const createEnrollmentTerm = { type: 'CREATE_ENROLLMENT_TERM', method: 'post', key: 'create_enrollment_termcreate_enrollment_term_account_id', required: ['account_id'] };

// Update enrollment term
// Update an existing enrollment term for the specified account.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollment_terms.html
// API Url: accounts/{account_id}/terms/{id}
//
// Example:
// const query = {
//   enrollment_term[name]
//   enrollment_term[start_at]
//   enrollment_term[end_at]
//   enrollment_term[sis_term_id]
//   enrollment_term[overrides][enrollment_type][start_at]
//   enrollment_term[overrides][enrollment_type][end_at]
// }
// return canvasRequest(update_enrollment_term, {account_id, id}, query);
export const updateEnrollmentTerm = { type: 'UPDATE_ENROLLMENT_TERM', method: 'put', key: 'update_enrollment_termupdate_enrollment_term_{account_id}_{id}', required: ['account_id', 'id'] };

// Delete enrollment term
// Delete the specified enrollment term.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollment_terms.html
// API Url: accounts/{account_id}/terms/{id}
//
// Example:
// return canvasRequest(delete_enrollment_term, {account_id, id});
export const deleteEnrollmentTerm = { type: 'DELETE_ENROLLMENT_TERM', method: 'delete', key: 'delete_enrollment_termdelete_enrollment_term_{account_id}_{id}', required: ['account_id', 'id'] };

// List enrollment terms
// Return all of the terms in the account.
//
// API Docs: https://canvas.instructure.com/doc/api/enrollment_terms.html
// API Url: accounts/{account_id}/terms
//
// Example:
// const query = {
//   workflow_state
//   include
// }
// return canvasRequest(list_enrollment_terms, {account_id}, query);
export const listEnrollmentTerms = { type: 'LIST_ENROLLMENT_TERMS', method: 'get', key: 'list_enrollment_termslist_enrollment_terms_account_id', required: ['account_id'] };