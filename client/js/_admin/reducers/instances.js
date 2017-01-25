import _    from 'lodash';

const initialState = {};

export default function instances(state = initialState, action) {
  switch (action.type) {

    case 'GET_APPLICATION_INSTANCES_DONE': {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (instance) => {
        newState[instance.id] = instance;
      });
      return newState;
    }

    default:
      return state;
  }
}
