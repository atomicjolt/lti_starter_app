//
// Accounts
//
// List accounts
// List accounts that the current user can view or manage.  Typically,
// students and even teachers will get an empty list in response, only
// account admins can view the accounts that they are in.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(list_accounts, {}, query);
export const listAccounts = { type: 'LIST_ACCOUNTS', method: 'get', key: 'list_accounts', required: [] };

// List accounts for course admins
// List accounts that the current user can view through their admin course enrollments.
// (Teacher, TA, or designer enrollments).
// Only returns "id", "name", "workflow_state", "root_account_id" and "parent_account_id"
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: course_accounts
//
// Example:
// return canvasRequest(list_accounts_for_course_admins, {});
export const listAccountsForCourseAdmins = { type: 'LIST_ACCOUNTS_FOR_COURSE_ADMINS', method: 'get', key: 'list_accounts_for_course_admins', required: [] };

// Get a single account
// Retrieve information on an individual account, given by id or sis
// sis_account_id.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts/{id}
//
// Example:
// return canvasRequest(get_single_account, {id});
export const getSingleAccount = { type: 'GET_SINGLE_ACCOUNT', method: 'get', key: 'get_single_accountget_single_account_id', required: ['id'] };

// Get the sub-accounts of an account
// List accounts that are sub-accounts of the given account.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts/{account_id}/sub_accounts
//
// Example:
// const query = {
//   recursive
// }
// return canvasRequest(get_sub_accounts_of_account, {account_id}, query);
export const getSubAccountsOfAccount = { type: 'GET_SUB_ACCOUNTS_OF_ACCOUNT', method: 'get', key: 'get_sub_accounts_of_accountget_sub_accounts_of_account_account_id', required: ['account_id'] };

// List active courses in an account
// Retrieve the list of courses in this account.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts/{account_id}/courses
//
// Example:
// const query = {
//   with_enrollments
//   enrollment_type
//   published
//   completed
//   by_teachers
//   by_subaccounts
//   hide_enrollmentless_courses
//   state
//   enrollment_term_id
//   search_term
//   include
// }
// return canvasRequest(list_active_courses_in_account, {account_id}, query);
export const listActiveCoursesInAccount = { type: 'LIST_ACTIVE_COURSES_IN_ACCOUNT', method: 'get', key: 'list_active_courses_in_accountlist_active_courses_in_account_account_id', required: ['account_id'] };

// Update an account
// Update an existing account.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts/{id}
//
// Example:
// const query = {
//   account[name]
//   account[default_time_zone]
//   account[default_storage_quota_mb]
//   account[default_user_storage_quota_mb]
//   account[default_group_storage_quota_mb]
//   account[settings][restrict_student_past_view][value]
//   account[settings][restrict_student_past_view][locked]
//   account[settings][restrict_student_future_view][value]
//   account[settings][restrict_student_future_view][locked]
//   account[settings][lock_all_announcements][value]
//   account[settings][lock_all_announcements][locked]
//   account[settings][restrict_student_future_listing][value]
//   account[settings][restrict_student_future_listing][locked]
//   account[services]
// }
// return canvasRequest(update_account, {id}, query);
export const updateAccount = { type: 'UPDATE_ACCOUNT', method: 'put', key: 'update_accountupdate_account_id', required: ['id'] };

// Delete a user from the root account
// Delete a user record from a Canvas root account. If a user is associated
// with multiple root accounts (in a multi-tenant instance of Canvas), this
// action will NOT remove them from the other accounts.
// 
// WARNING: This API will allow a user to remove themselves from the account.
// If they do this, they won't be able to make API calls or log into Canvas at
// that account.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts/{account_id}/users/{user_id}
//
// Example:
// return canvasRequest(delete_user_from_root_account, {account_id, user_id});
export const deleteUserFromRootAccount = { type: 'DELETE_USER_FROM_ROOT_ACCOUNT', method: 'delete', key: 'delete_user_from_root_accountdelete_user_from_root_account_{account_id}_{user_id}', required: ['account_id', 'user_id'] };

// Create a new sub-account
// Add a new sub-account to a given account.
//
// API Docs: https://canvas.instructure.com/doc/api/accounts.html
// API Url: accounts/{account_id}/sub_accounts
//
// Example:
// const query = {
//   account[name] (required)
//   account[sis_account_id]
//   account[default_storage_quota_mb]
//   account[default_user_storage_quota_mb]
//   account[default_group_storage_quota_mb]
// }
// return canvasRequest(create_new_sub_account, {account_id}, query);
export const createNewSubAccount = { type: 'CREATE_NEW_SUB_ACCOUNT', method: 'post', key: 'create_new_sub_accountcreate_new_sub_account_account_id', required: ['account_id'] };