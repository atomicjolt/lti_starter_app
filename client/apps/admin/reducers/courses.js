import _             from 'lodash';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {
    case 'LIST_ACTIVE_COURSES_IN_ACCOUNT_DONE': {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (course) => {
        newState[course.id] = course;
      });
      return newState;
    }

    case 'LIST_EXTERNAL_TOOLS_COURSES_DONE': {
      const newState = _.cloneDeep(state);
      const course = newState[action.original.params.course_id];

      if (_.isUndefined(course.external_tools)) {
        course.external_tools = {};
      }

      _.forEach(action.payload, (exTool) => {
        course.external_tools[exTool.id] = exTool;
      });

      return newState;
    }

    case 'CREATE_EXTERNAL_TOOL_COURSES_DONE': {
      const newState = _.cloneDeep(state);
      const courseId = action.original.params.course_id;
      const eternalToolId = action.payload.id;
      if (courseId) {
        if (_.isUndefined(newState[courseId].external_tools)) {
          newState[courseId].external_tools = {};
        }
        newState[courseId].external_tools[eternalToolId] = action.payload;
      } else {
        throw new Error(`Unable to find course with id: ${courseId} to set external tools`);
      }
      return newState;
    }

    case 'DELETE_EXTERNAL_TOOL_COURSES_DONE': {
      const newState = _.cloneDeep(state);
      const course = newState[action.original.params.course_id];
      delete course.external_tools[action.payload.id];
      return newState;
    }

    default:
      return state;
  }
};
