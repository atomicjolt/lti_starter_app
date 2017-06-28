//
// Planner Note
//
// List planner notes
// Retrieve the list of planner notes
// 
// Retrieve planner note for a user
//
// API Docs: https://canvas.instructure.com/doc/api/planner_note.html
// API Url: planner_notes
//
// Example:
// return canvasRequest(list_planner_notes, {});
export const listPlannerNotes = { type: 'LIST_PLANNER_NOTES', method: 'get', key: 'list_planner_notes', required: [] };

// Show a PlannerNote
// Retrieve a planner note for the current user
//
// API Docs: https://canvas.instructure.com/doc/api/planner_note.html
// API Url: planner_notes/{id}
//
// Example:
// return canvasRequest(show_plannernote, {id});
export const showPlannernote = { type: 'SHOW_PLANNERNOTE', method: 'get', key: 'show_plannernoteshow_plannernote_id', required: ['id'] };

// Update a PlannerNote
// Update a planner note for the current user
//
// API Docs: https://canvas.instructure.com/doc/api/planner_note.html
// API Url: planner_notes/{id}
//
// Example:
// return canvasRequest(update_plannernote, {id});
export const updatePlannernote = { type: 'UPDATE_PLANNERNOTE', method: 'put', key: 'update_plannernoteupdate_plannernote_id', required: ['id'] };

// Create a planner note
// Create a planner note for the current user
//
// API Docs: https://canvas.instructure.com/doc/api/planner_note.html
// API Url: planner_notes
//
// Example:
// return canvasRequest(create_planner_note, {});
export const createPlannerNote = { type: 'CREATE_PLANNER_NOTE', method: 'post', key: 'create_planner_note', required: [] };

// Delete a planner note
// Delete a planner note for the current user
//
// API Docs: https://canvas.instructure.com/doc/api/planner_note.html
// API Url: planner_notes/{id}
//
// Example:
// return canvasRequest(delete_planner_note, {id});
export const deletePlannerNote = { type: 'DELETE_PLANNER_NOTE', method: 'delete', key: 'delete_planner_notedelete_planner_note_id', required: ['id'] };