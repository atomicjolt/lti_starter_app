import _    from 'lodash';
import { Constants as ApplicationInstancesConstants } from '../actions/application_instances';
const initialState = {};

export default function instances(state = initialState, action) {
  switch (action.type) {

    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCES_DONE: {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (instance) => {
        newState[instance.id] = instance;
      });
      return newState;
    }

    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCE_DONE: {
      const newState = _.cloneDeep(state);
      newState[action.payload.id] = action.payload;
      return newState;
    }

    case ApplicationInstancesConstants.CREATE_APPLICATION_INSTANCE_DONE: {
      const newState = _.cloneDeep(state);
      newState[action.payload.id] = action.payload;
      return newState;
    }

    case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE_DONE: {
      const newState = _.cloneDeep(state);
      delete newState[action.original.applicationInstanceId];
      return newState;
    }

    default:
      return state;
  }
}
