import _ from 'lodash';
import { Constants as ApplicationInstancesConstants } from '../actions/application_instances';

const initialState = {
  applicationInstances: {},
  totalPages: 1,
};

export default function instances(state = initialState, action) {
  switch (action.type) {

    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCES_DONE: {
      const newState = _.cloneDeep(initialState);
      const {
        application_instances:applicationInstances,
        total_pages:totalPages,
      } = action.payload;
      _.forEach(applicationInstances, (instance) => {
        const instanceClone = _.cloneDeep(instance);
        instanceClone.config = JSON.stringify(instance.config);
        instanceClone.lti_config = JSON.stringify(instance.lti_config);
        newState.applicationInstances[instance.id] = instanceClone;
      });
      newState.totalPages = totalPages;
      return newState;
    }

    case ApplicationInstancesConstants.DISABLE_APPLICATION_INSTANCE_DONE:
    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCE_DONE:
    case ApplicationInstancesConstants.SAVE_APPLICATION_INSTANCE_DONE:
    case ApplicationInstancesConstants.CREATE_APPLICATION_INSTANCE_DONE: {
      const newState = _.cloneDeep(state);
      const instanceClone = _.cloneDeep(action.payload);
      instanceClone.config = JSON.stringify(action.payload.config);
      instanceClone.lti_config = JSON.stringify(action.payload.lti_config);
      newState.applicationInstances[action.payload.id] = instanceClone;
      return newState;
    }

    case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE_DONE: {
      const newState = _.cloneDeep(state);
      delete newState.applicationInstances[action.original.applicationInstanceId];
      return newState;
    }

    default:
      return state;
  }
}
