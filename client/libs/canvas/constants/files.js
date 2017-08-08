//
// Files
//
// Get quota information
// Returns the total and used storage quota for the course, group, or user.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/files/quota
//
// Example:
// return canvasRequest(get_quota_information_courses, {course_id});
export const getQuotaInformationCourses = { type: 'GET_QUOTA_INFORMATION_COURSES', method: 'get', key: 'get_quota_information_coursesget_quota_information_courses_course_id', required: ['course_id'] };

// Get quota information
// Returns the total and used storage quota for the course, group, or user.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/files/quota
//
// Example:
// return canvasRequest(get_quota_information_groups, {group_id});
export const getQuotaInformationGroups = { type: 'GET_QUOTA_INFORMATION_GROUPS', method: 'get', key: 'get_quota_information_groupsget_quota_information_groups_group_id', required: ['group_id'] };

// Get quota information
// Returns the total and used storage quota for the course, group, or user.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/files/quota
//
// Example:
// return canvasRequest(get_quota_information_users, {user_id});
export const getQuotaInformationUsers = { type: 'GET_QUOTA_INFORMATION_USERS', method: 'get', key: 'get_quota_information_usersget_quota_information_users_user_id', required: ['user_id'] };

// List files
// Returns the paginated list of files for the folder or course.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/files
//
// Example:
// const query = {
//   content_types
//   search_term
//   include
//   only
//   sort
//   order
// }
// return canvasRequest(list_files_courses, {course_id}, query);
export const listFilesCourses = { type: 'LIST_FILES_COURSES', method: 'get', key: 'list_files_courseslist_files_courses_course_id', required: ['course_id'] };

// List files
// Returns the paginated list of files for the folder or course.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/files
//
// Example:
// const query = {
//   content_types
//   search_term
//   include
//   only
//   sort
//   order
// }
// return canvasRequest(list_files_users, {user_id}, query);
export const listFilesUsers = { type: 'LIST_FILES_USERS', method: 'get', key: 'list_files_userslist_files_users_user_id', required: ['user_id'] };

// List files
// Returns the paginated list of files for the folder or course.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/files
//
// Example:
// const query = {
//   content_types
//   search_term
//   include
//   only
//   sort
//   order
// }
// return canvasRequest(list_files_groups, {group_id}, query);
export const listFilesGroups = { type: 'LIST_FILES_GROUPS', method: 'get', key: 'list_files_groupslist_files_groups_group_id', required: ['group_id'] };

// List files
// Returns the paginated list of files for the folder or course.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{id}/files
//
// Example:
// const query = {
//   content_types
//   search_term
//   include
//   only
//   sort
//   order
// }
// return canvasRequest(list_files_folders, {id}, query);
export const listFilesFolders = { type: 'LIST_FILES_FOLDERS', method: 'get', key: 'list_files_folderslist_files_folders_id', required: ['id'] };

// Get public inline preview url
// Determine the URL that should be used for inline preview of the file.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: files/{id}/public_url
//
// Example:
// const query = {
//   submission_id
// }
// return canvasRequest(get_public_inline_preview_url, {id}, query);
export const getPublicInlinePreviewUrl = { type: 'GET_PUBLIC_INLINE_PREVIEW_URL', method: 'get', key: 'get_public_inline_preview_urlget_public_inline_preview_url_id', required: ['id'] };

// Get file
// Returns the standard attachment json object
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: files/{id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_file_files, {id}, query);
export const getFileFiles = { type: 'GET_FILE_FILES', method: 'get', key: 'get_file_filesget_file_files_id', required: ['id'] };

// Get file
// Returns the standard attachment json object
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/files/{id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_file_courses, {course_id, id}, query);
export const getFileCourses = { type: 'GET_FILE_COURSES', method: 'get', key: 'get_file_coursesget_file_courses_{course_id}_{id}', required: ['course_id', 'id'] };

// Get file
// Returns the standard attachment json object
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/files/{id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_file_groups, {group_id, id}, query);
export const getFileGroups = { type: 'GET_FILE_GROUPS', method: 'get', key: 'get_file_groupsget_file_groups_{group_id}_{id}', required: ['group_id', 'id'] };

// Get file
// Returns the standard attachment json object
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/files/{id}
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(get_file_users, {user_id, id}, query);
export const getFileUsers = { type: 'GET_FILE_USERS', method: 'get', key: 'get_file_usersget_file_users_{user_id}_{id}', required: ['user_id', 'id'] };

// Update file
// Update some settings on the specified file
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: files/{id}
//
// Example:
// const query = {
//   name
//   parent_folder_id
//   on_duplicate
//   lock_at
//   unlock_at
//   locked
//   hidden
// }
// return canvasRequest(update_file, {id}, query);
export const updateFile = { type: 'UPDATE_FILE', method: 'put', key: 'update_fileupdate_file_id', required: ['id'] };

// Delete file
// Remove the specified file
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: files/{id}
//
// Example:
// const query = {
//   replace
// }
// return canvasRequest(delete_file, {id}, query);
export const deleteFile = { type: 'DELETE_FILE', method: 'delete', key: 'delete_filedelete_file_id', required: ['id'] };

// List folders
// Returns the paginated list of folders in the folder.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{id}/folders
//
// Example:
// return canvasRequest(list_folders, {id});
export const listFolders = { type: 'LIST_FOLDERS', method: 'get', key: 'list_folderslist_folders_id', required: ['id'] };

// List all folders
// Returns the paginated list of all folders for the given context. This will
// be returned as a flat list containing all subfolders as well.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/folders
//
// Example:
// return canvasRequest(list_all_folders_courses, {course_id});
export const listAllFoldersCourses = { type: 'LIST_ALL_FOLDERS_COURSES', method: 'get', key: 'list_all_folders_courseslist_all_folders_courses_course_id', required: ['course_id'] };

// List all folders
// Returns the paginated list of all folders for the given context. This will
// be returned as a flat list containing all subfolders as well.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/folders
//
// Example:
// return canvasRequest(list_all_folders_users, {user_id});
export const listAllFoldersUsers = { type: 'LIST_ALL_FOLDERS_USERS', method: 'get', key: 'list_all_folders_userslist_all_folders_users_user_id', required: ['user_id'] };

// List all folders
// Returns the paginated list of all folders for the given context. This will
// be returned as a flat list containing all subfolders as well.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/folders
//
// Example:
// return canvasRequest(list_all_folders_groups, {group_id});
export const listAllFoldersGroups = { type: 'LIST_ALL_FOLDERS_GROUPS', method: 'get', key: 'list_all_folders_groupslist_all_folders_groups_group_id', required: ['group_id'] };

// Resolve path
// Given the full path to a folder, returns a list of all Folders in the path hierarchy,
// starting at the root folder, and ending at the requested folder. The given path is
// relative to the context's root folder and does not include the root folder's name
// (e.g., "course files"). If an empty path is given, the context's root folder alone
// is returned. Otherwise, if no folder exists with the given full path, a Not Found
// error is returned.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/folders/by_path/*full_path
//
// Example:
// return canvasRequest(resolve_path_courses_full_path, {course_id});
export const resolvePathCoursesFullPath = { type: 'RESOLVE_PATH_COURSES_FULL_PATH', method: 'get', key: 'resolve_path_courses_full_pathresolve_path_courses_full_path_course_id', required: ['course_id'] };

// Resolve path
// Given the full path to a folder, returns a list of all Folders in the path hierarchy,
// starting at the root folder, and ending at the requested folder. The given path is
// relative to the context's root folder and does not include the root folder's name
// (e.g., "course files"). If an empty path is given, the context's root folder alone
// is returned. Otherwise, if no folder exists with the given full path, a Not Found
// error is returned.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/folders/by_path
//
// Example:
// return canvasRequest(resolve_path_courses, {course_id});
export const resolvePathCourses = { type: 'RESOLVE_PATH_COURSES', method: 'get', key: 'resolve_path_coursesresolve_path_courses_course_id', required: ['course_id'] };

// Resolve path
// Given the full path to a folder, returns a list of all Folders in the path hierarchy,
// starting at the root folder, and ending at the requested folder. The given path is
// relative to the context's root folder and does not include the root folder's name
// (e.g., "course files"). If an empty path is given, the context's root folder alone
// is returned. Otherwise, if no folder exists with the given full path, a Not Found
// error is returned.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/folders/by_path/*full_path
//
// Example:
// return canvasRequest(resolve_path_users_full_path, {user_id});
export const resolvePathUsersFullPath = { type: 'RESOLVE_PATH_USERS_FULL_PATH', method: 'get', key: 'resolve_path_users_full_pathresolve_path_users_full_path_user_id', required: ['user_id'] };

// Resolve path
// Given the full path to a folder, returns a list of all Folders in the path hierarchy,
// starting at the root folder, and ending at the requested folder. The given path is
// relative to the context's root folder and does not include the root folder's name
// (e.g., "course files"). If an empty path is given, the context's root folder alone
// is returned. Otherwise, if no folder exists with the given full path, a Not Found
// error is returned.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/folders/by_path
//
// Example:
// return canvasRequest(resolve_path_users, {user_id});
export const resolvePathUsers = { type: 'RESOLVE_PATH_USERS', method: 'get', key: 'resolve_path_usersresolve_path_users_user_id', required: ['user_id'] };

// Resolve path
// Given the full path to a folder, returns a list of all Folders in the path hierarchy,
// starting at the root folder, and ending at the requested folder. The given path is
// relative to the context's root folder and does not include the root folder's name
// (e.g., "course files"). If an empty path is given, the context's root folder alone
// is returned. Otherwise, if no folder exists with the given full path, a Not Found
// error is returned.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/folders/by_path/*full_path
//
// Example:
// return canvasRequest(resolve_path_groups_full_path, {group_id});
export const resolvePathGroupsFullPath = { type: 'RESOLVE_PATH_GROUPS_FULL_PATH', method: 'get', key: 'resolve_path_groups_full_pathresolve_path_groups_full_path_group_id', required: ['group_id'] };

// Resolve path
// Given the full path to a folder, returns a list of all Folders in the path hierarchy,
// starting at the root folder, and ending at the requested folder. The given path is
// relative to the context's root folder and does not include the root folder's name
// (e.g., "course files"). If an empty path is given, the context's root folder alone
// is returned. Otherwise, if no folder exists with the given full path, a Not Found
// error is returned.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/folders/by_path
//
// Example:
// return canvasRequest(resolve_path_groups, {group_id});
export const resolvePathGroups = { type: 'RESOLVE_PATH_GROUPS', method: 'get', key: 'resolve_path_groupsresolve_path_groups_group_id', required: ['group_id'] };

// Get folder
// Returns the details for a folder
// 
// You can get the root folder from a context by using 'root' as the :id.
// For example, you could get the root folder for a course like:
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/folders/{id}
//
// Example:
// return canvasRequest(get_folder_courses, {course_id, id});
export const getFolderCourses = { type: 'GET_FOLDER_COURSES', method: 'get', key: 'get_folder_coursesget_folder_courses_{course_id}_{id}', required: ['course_id', 'id'] };

// Get folder
// Returns the details for a folder
// 
// You can get the root folder from a context by using 'root' as the :id.
// For example, you could get the root folder for a course like:
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/folders/{id}
//
// Example:
// return canvasRequest(get_folder_users, {user_id, id});
export const getFolderUsers = { type: 'GET_FOLDER_USERS', method: 'get', key: 'get_folder_usersget_folder_users_{user_id}_{id}', required: ['user_id', 'id'] };

// Get folder
// Returns the details for a folder
// 
// You can get the root folder from a context by using 'root' as the :id.
// For example, you could get the root folder for a course like:
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/folders/{id}
//
// Example:
// return canvasRequest(get_folder_groups, {group_id, id});
export const getFolderGroups = { type: 'GET_FOLDER_GROUPS', method: 'get', key: 'get_folder_groupsget_folder_groups_{group_id}_{id}', required: ['group_id', 'id'] };

// Get folder
// Returns the details for a folder
// 
// You can get the root folder from a context by using 'root' as the :id.
// For example, you could get the root folder for a course like:
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{id}
//
// Example:
// return canvasRequest(get_folder_folders, {id});
export const getFolderFolders = { type: 'GET_FOLDER_FOLDERS', method: 'get', key: 'get_folder_foldersget_folder_folders_id', required: ['id'] };

// Update folder
// Updates a folder
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{id}
//
// Example:
// const query = {
//   name
//   parent_folder_id
//   lock_at
//   unlock_at
//   locked
//   hidden
//   position
// }
// return canvasRequest(update_folder, {id}, query);
export const updateFolder = { type: 'UPDATE_FOLDER', method: 'put', key: 'update_folderupdate_folder_id', required: ['id'] };

// Create folder
// Creates a folder in the specified context
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/folders
//
// Example:
// const query = {
//   name (required)
//   parent_folder_id
//   parent_folder_path
//   lock_at
//   unlock_at
//   locked
//   hidden
//   position
// }
// return canvasRequest(create_folder_courses, {course_id}, query);
export const createFolderCourses = { type: 'CREATE_FOLDER_COURSES', method: 'post', key: 'create_folder_coursescreate_folder_courses_course_id', required: ['course_id'] };

// Create folder
// Creates a folder in the specified context
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/folders
//
// Example:
// const query = {
//   name (required)
//   parent_folder_id
//   parent_folder_path
//   lock_at
//   unlock_at
//   locked
//   hidden
//   position
// }
// return canvasRequest(create_folder_users, {user_id}, query);
export const createFolderUsers = { type: 'CREATE_FOLDER_USERS', method: 'post', key: 'create_folder_userscreate_folder_users_user_id', required: ['user_id'] };

// Create folder
// Creates a folder in the specified context
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/folders
//
// Example:
// const query = {
//   name (required)
//   parent_folder_id
//   parent_folder_path
//   lock_at
//   unlock_at
//   locked
//   hidden
//   position
// }
// return canvasRequest(create_folder_groups, {group_id}, query);
export const createFolderGroups = { type: 'CREATE_FOLDER_GROUPS', method: 'post', key: 'create_folder_groupscreate_folder_groups_group_id', required: ['group_id'] };

// Create folder
// Creates a folder in the specified context
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{folder_id}/folders
//
// Example:
// const query = {
//   name (required)
//   parent_folder_id
//   parent_folder_path
//   lock_at
//   unlock_at
//   locked
//   hidden
//   position
// }
// return canvasRequest(create_folder_folders, {folder_id}, query);
export const createFolderFolders = { type: 'CREATE_FOLDER_FOLDERS', method: 'post', key: 'create_folder_folderscreate_folder_folders_folder_id', required: ['folder_id'] };

// Delete folder
// Remove the specified folder. You can only delete empty folders unless you
// set the 'force' flag
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{id}
//
// Example:
// const query = {
//   force
// }
// return canvasRequest(delete_folder, {id}, query);
export const deleteFolder = { type: 'DELETE_FOLDER', method: 'delete', key: 'delete_folderdelete_folder_id', required: ['id'] };

// Upload a file
// Upload a file to a folder.
// 
// This API endpoint is the first step in uploading a file.
// See the {file:file_uploads.html File Upload Documentation} for details on
// the file upload workflow.
// 
// Only those with the "Manage Files" permission on a course or group can
// upload files to a folder in that course or group.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{folder_id}/files
//
// Example:
// return canvasRequest(files_upload_file, {folder_id});
export const filesUploadFile = { type: 'FILES_UPLOAD_FILE', method: 'post', key: 'files_upload_filefiles_upload_file_folder_id', required: ['folder_id'] };

// Copy a file
// Copy a file from elsewhere in Canvas into a folder.
// 
// Copying a file across contexts (between courses and users) is permitted,
// but the source and destination must belong to the same institution.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{dest_folder_id}/copy_file
//
// Example:
// const query = {
//   source_file_id (required)
//   on_duplicate
// }
// return canvasRequest(copy_file, {dest_folder_id}, query);
export const copyFile = { type: 'COPY_FILE', method: 'post', key: 'copy_filecopy_file_dest_folder_id', required: ['dest_folder_id'] };

// Copy a folder
// Copy a folder (and its contents) from elsewhere in Canvas into a folder.
// 
// Copying a folder across contexts (between courses and users) is permitted,
// but the source and destination must belong to the same institution.
// If the source and destination folders are in the same context, the
// source folder may not contain the destination folder. A folder will be
// renamed at its destination if another folder with the same name already
// exists.
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: folders/{dest_folder_id}/copy_folder
//
// Example:
// const query = {
//   source_folder_id (required)
// }
// return canvasRequest(copy_folder, {dest_folder_id}, query);
export const copyFolder = { type: 'COPY_FOLDER', method: 'post', key: 'copy_foldercopy_folder_dest_folder_id', required: ['dest_folder_id'] };

// Set usage rights
// Sets copyright and license information for one or more files
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/usage_rights
//
// Example:
// const query = {
//   file_ids (required)
//   folder_ids
//   publish
//   usage_rights[use_justification] (required)
//   usage_rights[legal_copyright]
//   usage_rights[license]
// }
// return canvasRequest(set_usage_rights_courses, {course_id}, query);
export const setUsageRightsCourses = { type: 'SET_USAGE_RIGHTS_COURSES', method: 'put', key: 'set_usage_rights_coursesset_usage_rights_courses_course_id', required: ['course_id'] };

// Set usage rights
// Sets copyright and license information for one or more files
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/usage_rights
//
// Example:
// const query = {
//   file_ids (required)
//   folder_ids
//   publish
//   usage_rights[use_justification] (required)
//   usage_rights[legal_copyright]
//   usage_rights[license]
// }
// return canvasRequest(set_usage_rights_groups, {group_id}, query);
export const setUsageRightsGroups = { type: 'SET_USAGE_RIGHTS_GROUPS', method: 'put', key: 'set_usage_rights_groupsset_usage_rights_groups_group_id', required: ['group_id'] };

// Set usage rights
// Sets copyright and license information for one or more files
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/usage_rights
//
// Example:
// const query = {
//   file_ids (required)
//   folder_ids
//   publish
//   usage_rights[use_justification] (required)
//   usage_rights[legal_copyright]
//   usage_rights[license]
// }
// return canvasRequest(set_usage_rights_users, {user_id}, query);
export const setUsageRightsUsers = { type: 'SET_USAGE_RIGHTS_USERS', method: 'put', key: 'set_usage_rights_usersset_usage_rights_users_user_id', required: ['user_id'] };

// Remove usage rights
// Removes copyright and license information associated with one or more files
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/usage_rights
//
// Example:
// const query = {
//   file_ids (required)
//   folder_ids
// }
// return canvasRequest(remove_usage_rights_courses, {course_id}, query);
export const removeUsageRightsCourses = { type: 'REMOVE_USAGE_RIGHTS_COURSES', method: 'delete', key: 'remove_usage_rights_coursesremove_usage_rights_courses_course_id', required: ['course_id'] };

// Remove usage rights
// Removes copyright and license information associated with one or more files
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/usage_rights
//
// Example:
// const query = {
//   file_ids (required)
//   folder_ids
// }
// return canvasRequest(remove_usage_rights_groups, {group_id}, query);
export const removeUsageRightsGroups = { type: 'REMOVE_USAGE_RIGHTS_GROUPS', method: 'delete', key: 'remove_usage_rights_groupsremove_usage_rights_groups_group_id', required: ['group_id'] };

// Remove usage rights
// Removes copyright and license information associated with one or more files
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/usage_rights
//
// Example:
// const query = {
//   file_ids (required)
//   folder_ids
// }
// return canvasRequest(remove_usage_rights_users, {user_id}, query);
export const removeUsageRightsUsers = { type: 'REMOVE_USAGE_RIGHTS_USERS', method: 'delete', key: 'remove_usage_rights_usersremove_usage_rights_users_user_id', required: ['user_id'] };

// List licenses
// Lists licenses that can be applied
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: courses/{course_id}/content_licenses
//
// Example:
// return canvasRequest(list_licenses_courses, {course_id});
export const listLicensesCourses = { type: 'LIST_LICENSES_COURSES', method: 'get', key: 'list_licenses_courseslist_licenses_courses_course_id', required: ['course_id'] };

// List licenses
// Lists licenses that can be applied
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: groups/{group_id}/content_licenses
//
// Example:
// return canvasRequest(list_licenses_groups, {group_id});
export const listLicensesGroups = { type: 'LIST_LICENSES_GROUPS', method: 'get', key: 'list_licenses_groupslist_licenses_groups_group_id', required: ['group_id'] };

// List licenses
// Lists licenses that can be applied
//
// API Docs: https://canvas.instructure.com/doc/api/files.html
// API Url: users/{user_id}/content_licenses
//
// Example:
// return canvasRequest(list_licenses_users, {user_id});
export const listLicensesUsers = { type: 'LIST_LICENSES_USERS', method: 'get', key: 'list_licenses_userslist_licenses_users_user_id', required: ['user_id'] };