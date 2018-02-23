import _ from 'lodash';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {
    case 'LIST_EXTERNAL_TOOLS_COURSES': {
      const newState = _.cloneDeep(state);
      newState[action.localData] = true;
      return newState;
    }

    case 'LIST_EXTERNAL_TOOLS_COURSES_DONE': {
      const newState = _.cloneDeep(state);
      delete newState[action.original.localData];
      return newState;
    }

    default:
      return state;
  }
};
