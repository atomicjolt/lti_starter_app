// Note. This reducer doesn't work and will need a fair amount 
import _                   from "lodash";

export default (state = {}, action) => {

  if(action.canvas){
    const state = state.get(action.canvas.key);

    if(_.endsWith(action.type, "_DONE")){

      switch(action.canvas.method){
        case 'get':
          const mapped = _.reduce(action.payload, (result, as) => { result[as.id] = as; return result; }, {});
          return state.merge(mapped);
        case 'post':
          const newState = _.deepClone(state);
          newState[action.payload.id] = action.payload;
        case 'put':
          return state;
        case 'delete':
          return state;
      }
    } else {

      // Optimistic updates
      switch(action.canvas.method){
        case 'post':
          return state;
        case 'put':
          return state;
        case 'delete':
          return state;
      }
    }
  }

  return state;

};