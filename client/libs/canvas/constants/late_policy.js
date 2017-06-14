//
// Late Policy
//
// Get a late policy
// Returns the late policy for a course.
//
// API Docs: https://canvas.instructure.com/doc/api/late_policy.html
// API Url: courses/{id}/late_policy
//
// Example:
// return canvasRequest(get_late_policy, {id});
export const getLatePolicy = { type: 'GET_LATE_POLICY', method: 'get', key: 'get_late_policyget_late_policy_id', required: ['id'] };

// Create a late policy
// Create a late policy. If the course already has a late policy, a
// bad_request is returned since there can only be one late policy
// per course.
//
// API Docs: https://canvas.instructure.com/doc/api/late_policy.html
// API Url: courses/{id}/late_policy
//
// Example:
// const query = {
//   late_policy[missing_submission_deduction_enabled]
//   late_policy[missing_submission_deduction]
//   late_policy[late_submission_deduction_enabled]
//   late_policy[late_submission_deduction]
//   late_policy[late_submission_interval]
//   late_policy[late_submission_minimum_percent_enabled]
//   late_policy[late_submission_minimum_percent]
// }
// return canvasRequest(create_late_policy, {id}, query);
export const createLatePolicy = { type: 'CREATE_LATE_POLICY', method: 'post', key: 'create_late_policycreate_late_policy_id', required: ['id'] };

// Patch a late policy
// Patch a late policy. No body is returned upon success.
//
// API Docs: https://canvas.instructure.com/doc/api/late_policy.html
// API Url: courses/{id}/late_policy
//
// Example:
// const query = {
//   late_policy[missing_submission_deduction_enabled]
//   late_policy[missing_submission_deduction]
//   late_policy[late_submission_deduction_enabled]
//   late_policy[late_submission_deduction]
//   late_policy[late_submission_interval]
//   late_policy[late_submission_minimum_percent_enabled]
//   late_policy[late_submission_minimum_percent]
// }
// return canvasRequest(patch_late_policy, {id}, query);
export const patchLatePolicy = { type: 'PATCH_LATE_POLICY', method: 'patch', key: 'patch_late_policypatch_late_policy_id', required: ['id'] };