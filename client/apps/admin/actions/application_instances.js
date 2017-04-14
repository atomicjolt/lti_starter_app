import _ from 'lodash';
import wrapper from '../../constants/wrapper';
import Network from '../../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_APPLICATION_INSTANCES',
  'GET_APPLICATION_INSTANCE',
  'CREATE_APPLICATION_INSTANCE',
  'DELETE_APPLICATION_INSTANCE',
  'SAVE_APPLICATION_INSTANCE',
];

export const Constants = wrapper(actions, requests);

export function getApplicationInstances(applicationId) {
  return {
    type   : Constants.GET_APPLICATION_INSTANCES,
    method : Network.GET,
    url    : `/api/applications/${applicationId}/application_instances`,
  };
}

export function getApplicationInstance(applicationId, applicationInstanceId) {
  return {
    type   : Constants.GET_APPLICATION_INSTANCE,
    method : Network.GET,
    url    : `/api/applications/${applicationId}/application_instances/${applicationInstanceId}`,
  };
}

export function createApplicationInstance(applicationId, applicationInstance) {
  const appInstanceClone = _.cloneDeep(applicationInstance);
  appInstanceClone.config = JSON.parse(applicationInstance.config || '{}');
  return {
    type   : Constants.CREATE_APPLICATION_INSTANCE,
    method : Network.POST,
    url    : `/api/applications/${applicationId}/application_instances`,
    body   : {
      application_instance: appInstanceClone,
    }
  };
}

export function saveApplicationInstance(applicationId, applicationInstance) {
  const appInstanceClone = _.cloneDeep(applicationInstance);
  appInstanceClone.config = JSON.parse(applicationInstance.config || '{}');
  return {
    type: Constants.SAVE_APPLICATION_INSTANCE,
    method: Network.PUT,
    url: `/api/applications/${applicationId}/application_instances/${applicationInstance.id}`,
    body: {
      application_instance: appInstanceClone,
    }
  };
}

export function deleteApplicationInstance(applicationId, applicationInstanceId) {
  return {
    type   : Constants.DELETE_APPLICATION_INSTANCE,
    method : Network.DEL,
    url    : `/api/applications/${applicationId}/application_instances/${applicationInstanceId}`,
    applicationInstanceId,
  };
}
