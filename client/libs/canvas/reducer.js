// Note. This reducer doesn't work and will need a fair amount
import _                   from 'lodash';

export default (state = {}, action) => {

  if (action.canvas) {
    let newState = state.get(action.canvas.key);

    if (_.endsWith(action.type, '_DONE')) {

      switch (action.canvas.method) {
        case 'get': {
          const mapped = _.reduce(action.payload, (result, as) => ({
            ...result,
            [as.id]: as
          }), {});
          return newState.merge(mapped);
        }
        case 'post': {
          newState = _.deepClone(newState);
          newState[action.payload.id] = action.payload;
          return newState;
        }
        case 'put': {
          return newState;
        }
        case 'delete': {
          return newState;
        }
        default: {
          break;
        }
      }
    } else {

      // Optimistic updates
      switch (action.canvas.method) {
        case 'post': {
          return newState;
        }
        case 'put': {
          return newState;
        }
        case 'delete': {
          return newState;
        }
        default: {
          break;
        }
      }
    }
  }

  return state;

};
