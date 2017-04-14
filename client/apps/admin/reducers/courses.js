import _             from 'lodash';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {
    case 'LIST_ACTIVE_COURSES_IN_ACCOUNT_DONE': {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (course) => {
        const newCourse = _.cloneDeep(course);
        if (newState[course.id]) {
          newCourse.external_tools = newState[course.id].external_tools;
        }

        newState[course.id] = course;
      });
      return newState;
    }

    case 'LIST_EXTERNAL_TOOLS_COURSES_DONE': {
      const newState = _.cloneDeep(state);
      const course = newState[action.original.params.course_id];

      if (course.external_tools === undefined) {
        course.external_tools = {};
      }

      _.forEach(action.payload, (exTool) => {
        course.external_tools[exTool.id] = exTool;
      });

      return newState;
    }

    case 'CREATE_EXTERNAL_TOOL_COURSES_DONE': {
      const newState = _.cloneDeep(state);
      const course = newState[action.original.params.course_id];
      course.external_tools[action.payload.id] = action.payload;
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
