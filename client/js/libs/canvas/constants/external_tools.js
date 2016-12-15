//
// External Tools
//
// List external tools
// Returns the paginated list of external tools for the current context.
// See the get request docs for a single tool for a list of properties on an external tool.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: courses/{course_id}/external_tools
//
// Example:
// const query = {
//   search_term
//   selectable
// }
// return canvasRequest(list_external_tools_courses, {course_id}, query);
export const listExternalToolsCourses = { type: 'LIST_EXTERNAL_TOOLS_COURSES', method: 'get', key: 'list_external_tools_courseslist_external_tools_courses_course_id', required: ['course_id'] };

// List external tools
// Returns the paginated list of external tools for the current context.
// See the get request docs for a single tool for a list of properties on an external tool.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: accounts/{account_id}/external_tools
//
// Example:
// const query = {
//   search_term
//   selectable
// }
// return canvasRequest(list_external_tools_accounts, {account_id}, query);
export const listExternalToolsAccounts = { type: 'LIST_EXTERNAL_TOOLS_ACCOUNTS', method: 'get', key: 'list_external_tools_accountslist_external_tools_accounts_account_id', required: ['account_id'] };

// List external tools
// Returns the paginated list of external tools for the current context.
// See the get request docs for a single tool for a list of properties on an external tool.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: groups/{group_id}/external_tools
//
// Example:
// const query = {
//   search_term
//   selectable
// }
// return canvasRequest(list_external_tools_groups, {group_id}, query);
export const listExternalToolsGroups = { type: 'LIST_EXTERNAL_TOOLS_GROUPS', method: 'get', key: 'list_external_tools_groupslist_external_tools_groups_group_id', required: ['group_id'] };

// Get a sessionless launch url for an external tool.
// Returns a sessionless launch url for an external tool.
// 
// NOTE: Either the id or url must be provided unless launch_type is assessment or module_item.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: courses/{course_id}/external_tools/sessionless_launch
//
// Example:
// const query = {
//   id
//   url
//   assignment_id
//   module_item_id
//   launch_type
// }
// return canvasRequest(get_sessionless_launch_url_for_external_tool_courses, {course_id}, query);
export const getSessionlessLaunchUrlForExternalToolCourses = { type: 'GET_SESSIONLESS_LAUNCH_URL_FOR_EXTERNAL_TOOL_COURSES', method: 'get', key: 'get_sessionless_launch_url_for_external_tool_coursesget_sessionless_launch_url_for_external_tool_courses_course_id', required: ['course_id'] };

// Get a sessionless launch url for an external tool.
// Returns a sessionless launch url for an external tool.
// 
// NOTE: Either the id or url must be provided unless launch_type is assessment or module_item.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: accounts/{account_id}/external_tools/sessionless_launch
//
// Example:
// const query = {
//   id
//   url
//   assignment_id
//   module_item_id
//   launch_type
// }
// return canvasRequest(get_sessionless_launch_url_for_external_tool_accounts, {account_id}, query);
export const getSessionlessLaunchUrlForExternalToolAccounts = { type: 'GET_SESSIONLESS_LAUNCH_URL_FOR_EXTERNAL_TOOL_ACCOUNTS', method: 'get', key: 'get_sessionless_launch_url_for_external_tool_accountsget_sessionless_launch_url_for_external_tool_accounts_account_id', required: ['account_id'] };

// Get a single external tool
// Returns the specified external tool.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: courses/{course_id}/external_tools/{external_tool_id}
//
// Example:
// return canvasRequest(get_single_external_tool_courses, {course_id, external_tool_id});
export const getSingleExternalToolCourses = { type: 'GET_SINGLE_EXTERNAL_TOOL_COURSES', method: 'get', key: 'get_single_external_tool_coursesget_single_external_tool_courses_{course_id}_{external_tool_id}', required: ['course_id','external_tool_id'] };

// Get a single external tool
// Returns the specified external tool.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: accounts/{account_id}/external_tools/{external_tool_id}
//
// Example:
// return canvasRequest(get_single_external_tool_accounts, {account_id, external_tool_id});
export const getSingleExternalToolAccounts = { type: 'GET_SINGLE_EXTERNAL_TOOL_ACCOUNTS', method: 'get', key: 'get_single_external_tool_accountsget_single_external_tool_accounts_{account_id}_{external_tool_id}', required: ['account_id','external_tool_id'] };

// Create an external tool
// Create an external tool in the specified course/account.
// The created tool will be returned, see the "show" endpoint for an example.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: courses/{course_id}/external_tools
//
// Example:
// const query = {
//   name (required)
//   privacy_level (required)
//   consumer_key (required)
//   shared_secret (required)
//   description
//   url
//   domain
//   icon_url
//   text
//   custom_fields[field_name]
//   account_navigation[url]
//   account_navigation[enabled]
//   account_navigation[text]
//   account_navigation[selection_width]
//   account_navigation[selection_height]
//   user_navigation[url]
//   user_navigation[enabled]
//   user_navigation[text]
//   course_home_sub_navigation[url]
//   course_home_sub_navigation[enabled]
//   course_home_sub_navigation[text]
//   course_home_sub_navigation[icon_url]
//   course_navigation[enabled]
//   course_navigation[text]
//   course_navigation[visibility]
//   course_navigation[windowTarget]
//   course_navigation[default]
//   editor_button[url]
//   editor_button[enabled]
//   editor_button[icon_url]
//   editor_button[selection_width]
//   editor_button[selection_height]
//   editor_button[message_type]
//   homework_submission[url]
//   homework_submission[enabled]
//   homework_submission[text]
//   homework_submission[message_type]
//   link_selection[url]
//   link_selection[enabled]
//   link_selection[text]
//   link_selection[message_type]
//   migration_selection[url]
//   migration_selection[enabled]
//   migration_selection[message_type]
//   tool_configuration[url]
//   tool_configuration[enabled]
//   tool_configuration[message_type]
//   resource_selection[url]
//   resource_selection[enabled]
//   resource_selection[icon_url]
//   resource_selection[selection_width]
//   resource_selection[selection_height]
//   config_type
//   config_xml
//   config_url
//   not_selectable
// }
// return canvasRequest(create_external_tool_courses, {course_id}, query);
export const createExternalToolCourses = { type: 'CREATE_EXTERNAL_TOOL_COURSES', method: 'post', key: 'create_external_tool_coursescreate_external_tool_courses_course_id', required: ['course_id'] };

// Create an external tool
// Create an external tool in the specified course/account.
// The created tool will be returned, see the "show" endpoint for an example.
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: accounts/{account_id}/external_tools
//
// Example:
// const query = {
//   name (required)
//   privacy_level (required)
//   consumer_key (required)
//   shared_secret (required)
//   description
//   url
//   domain
//   icon_url
//   text
//   custom_fields[field_name]
//   account_navigation[url]
//   account_navigation[enabled]
//   account_navigation[text]
//   account_navigation[selection_width]
//   account_navigation[selection_height]
//   user_navigation[url]
//   user_navigation[enabled]
//   user_navigation[text]
//   course_home_sub_navigation[url]
//   course_home_sub_navigation[enabled]
//   course_home_sub_navigation[text]
//   course_home_sub_navigation[icon_url]
//   course_navigation[enabled]
//   course_navigation[text]
//   course_navigation[visibility]
//   course_navigation[windowTarget]
//   course_navigation[default]
//   editor_button[url]
//   editor_button[enabled]
//   editor_button[icon_url]
//   editor_button[selection_width]
//   editor_button[selection_height]
//   editor_button[message_type]
//   homework_submission[url]
//   homework_submission[enabled]
//   homework_submission[text]
//   homework_submission[message_type]
//   link_selection[url]
//   link_selection[enabled]
//   link_selection[text]
//   link_selection[message_type]
//   migration_selection[url]
//   migration_selection[enabled]
//   migration_selection[message_type]
//   tool_configuration[url]
//   tool_configuration[enabled]
//   tool_configuration[message_type]
//   resource_selection[url]
//   resource_selection[enabled]
//   resource_selection[icon_url]
//   resource_selection[selection_width]
//   resource_selection[selection_height]
//   config_type
//   config_xml
//   config_url
//   not_selectable
// }
// return canvasRequest(create_external_tool_accounts, {account_id}, query);
export const createExternalToolAccounts = { type: 'CREATE_EXTERNAL_TOOL_ACCOUNTS', method: 'post', key: 'create_external_tool_accountscreate_external_tool_accounts_account_id', required: ['account_id'] };

// Edit an external tool
// Update the specified external tool. Uses same parameters as create
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: courses/{course_id}/external_tools/{external_tool_id}
//
// Example:
// return canvasRequest(edit_external_tool_courses, {course_id, external_tool_id});
export const editExternalToolCourses = { type: 'EDIT_EXTERNAL_TOOL_COURSES', method: 'put', key: 'edit_external_tool_coursesedit_external_tool_courses_{course_id}_{external_tool_id}', required: ['course_id','external_tool_id'] };

// Edit an external tool
// Update the specified external tool. Uses same parameters as create
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: accounts/{account_id}/external_tools/{external_tool_id}
//
// Example:
// return canvasRequest(edit_external_tool_accounts, {account_id, external_tool_id});
export const editExternalToolAccounts = { type: 'EDIT_EXTERNAL_TOOL_ACCOUNTS', method: 'put', key: 'edit_external_tool_accountsedit_external_tool_accounts_{account_id}_{external_tool_id}', required: ['account_id','external_tool_id'] };

// Delete an external tool
// Remove the specified external tool
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: courses/{course_id}/external_tools/{external_tool_id}
//
// Example:
// return canvasRequest(delete_external_tool_courses, {course_id, external_tool_id});
export const deleteExternalToolCourses = { type: 'DELETE_EXTERNAL_TOOL_COURSES', method: 'delete', key: 'delete_external_tool_coursesdelete_external_tool_courses_{course_id}_{external_tool_id}', required: ['course_id','external_tool_id'] };

// Delete an external tool
// Remove the specified external tool
//
// API Docs: https://canvas.instructure.com/doc/api/external_tools.html
// API Url: accounts/{account_id}/external_tools/{external_tool_id}
//
// Example:
// return canvasRequest(delete_external_tool_accounts, {account_id, external_tool_id});
export const deleteExternalToolAccounts = { type: 'DELETE_EXTERNAL_TOOL_ACCOUNTS', method: 'delete', key: 'delete_external_tool_accountsdelete_external_tool_accounts_{account_id}_{external_tool_id}', required: ['account_id','external_tool_id'] };