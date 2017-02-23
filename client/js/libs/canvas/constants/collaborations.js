//
// Collaborations
//
// List collaborations
// List collaborations the current user has access to in the context of the course
// provided in the url. NOTE: this only returns ExternalToolCollaboration type
// collaborations.
// 
//   curl https://<canvas>/api/v1/courses/1/collaborations/
//
// API Docs: https://canvas.instructure.com/doc/api/collaborations.html
// API Url: courses/{course_id}/collaborations
//
// Example:
// return canvasRequest(list_collaborations_courses, {course_id});
export const listCollaborationsCourses = { type: 'LIST_COLLABORATIONS_COURSES', method: 'get', key: 'list_collaborations_courseslist_collaborations_courses_course_id', required: ['course_id'] };

// List collaborations
// List collaborations the current user has access to in the context of the course
// provided in the url. NOTE: this only returns ExternalToolCollaboration type
// collaborations.
// 
//   curl https://<canvas>/api/v1/courses/1/collaborations/
//
// API Docs: https://canvas.instructure.com/doc/api/collaborations.html
// API Url: groups/{group_id}/collaborations
//
// Example:
// return canvasRequest(list_collaborations_groups, {group_id});
export const listCollaborationsGroups = { type: 'LIST_COLLABORATIONS_GROUPS', method: 'get', key: 'list_collaborations_groupslist_collaborations_groups_group_id', required: ['group_id'] };

// List members of a collaboration.
// List the collaborators of a given collaboration
//
// API Docs: https://canvas.instructure.com/doc/api/collaborations.html
// API Url: collaborations/{id}/members
//
// Example:
// const query = {
//   include
// }
// return canvasRequest(list_members_of_collaboration, {id}, query);
export const listMembersOfCollaboration = { type: 'LIST_MEMBERS_OF_COLLABORATION', method: 'get', key: 'list_members_of_collaborationlist_members_of_collaboration_id', required: ['id'] };

// List potential members
// List the users who can potentially be added to a collaboration in the given context.
// 
// For courses, this consists of all enrolled users.  For groups, it is comprised of the
// group members plus the admins of the course containing the group.
//
// API Docs: https://canvas.instructure.com/doc/api/collaborations.html
// API Url: courses/{course_id}/potential_collaborators
//
// Example:
// return canvasRequest(list_potential_members_courses, {course_id});
export const listPotentialMembersCourses = { type: 'LIST_POTENTIAL_MEMBERS_COURSES', method: 'get', key: 'list_potential_members_courseslist_potential_members_courses_course_id', required: ['course_id'] };

// List potential members
// List the users who can potentially be added to a collaboration in the given context.
// 
// For courses, this consists of all enrolled users.  For groups, it is comprised of the
// group members plus the admins of the course containing the group.
//
// API Docs: https://canvas.instructure.com/doc/api/collaborations.html
// API Url: groups/{group_id}/potential_collaborators
//
// Example:
// return canvasRequest(list_potential_members_groups, {group_id});
export const listPotentialMembersGroups = { type: 'LIST_POTENTIAL_MEMBERS_GROUPS', method: 'get', key: 'list_potential_members_groupslist_potential_members_groups_group_id', required: ['group_id'] };