import _    from 'lodash';
import { Constants as ApplicationInstancesConstants } from '../actions/application_instances';

const initialState = {};

export default function instances(state = initialState, action) {
  switch (action.type) {

    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCES_DONE: {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (instance) => {
        const instanceClone = _.cloneDeep(instance);
        instanceClone.config = JSON.stringify(instance.config);
        instanceClone.lti_config = JSON.stringify(instance.lti_config);
        newState[instance.id] = instanceClone;
      });
      return newState;
    }

    case ApplicationInstancesConstants.DISABLE_APPLICATION_INSTANCE_DONE:
    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCE_DONE:
    case ApplicationInstancesConstants.SAVE_APPLICATION_INSTANCE_DONE:
    case ApplicationInstancesConstants.CREATE_APPLICATION_INSTANCE_DONE: {
      debugger
      const newState = _.cloneDeep(state);
      const instanceClone = _.cloneDeep(action.payload);
      instanceClone.config = JSON.stringify(action.payload.config);
      instanceClone.lti_config = JSON.stringify(action.payload.lti_config);
      newState[action.payload.id] = instanceClone;
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
