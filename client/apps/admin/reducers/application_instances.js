import _ from 'lodash';
import { Constants as ApplicationInstancesConstants } from '../actions/application_instances';

const initialState = {
  applicationInstances: [],
  totalPages: 1,
  loading: true,
  loaded: false,
  newApplicationInstance: {},
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
        newState.applicationInstances.push(instanceClone);
      });
      newState.totalPages = totalPages;
      newState.loading = false;
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
      _.remove(newState.applicationInstances, (ai) => (
        ai.id === action.payload.id
      ));
      newState.applicationInstances.push(instanceClone);
      newState.loading = false;
      newState.loaded = true;
      return newState;
    }

    case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.applicationInstances, (ai) => (
        ai.id === action.original.applicationInstanceId
      ));
      newState.loading = false;
      return newState;
    }

    case ApplicationInstancesConstants.UPDATE_NEW_INSTANCE: {
      const newState = _.cloneDeep(state);
      newState.newApplicationInstance = action.newApplicationInstance;
      return newState;
    }

    case ApplicationInstancesConstants.DISABLE_APPLICATION_INSTANCE:
    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCE:
    case ApplicationInstancesConstants.SAVE_APPLICATION_INSTANCE:
    case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE:
    case ApplicationInstancesConstants.GET_APPLICATION_INSTANCES:
    case ApplicationInstancesConstants.CREATE_APPLICATION_INSTANCE: {
      const newState = _.cloneDeep(state);
      newState.loading = true;
      return newState;
    }

    case ApplicationInstancesConstants.DELETE_APPLICATION_INSTANCE_AUTH_DONE: {
      const newState = _.cloneDeep(state);
      const applicationInstance = _.find(newState.applicationInstances, ai => (
        ai.id === action.original.applicationInstanceId
      ));
      _.remove(applicationInstance.authentications, au => (
        au.id === action.original.authenticationId
      ));
      return newState;
    }

    default:
      return state;
  }
}
