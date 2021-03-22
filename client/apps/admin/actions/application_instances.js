import _ from 'lodash';
import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_APPLICATION_INSTANCES',
  'GET_APPLICATION_INSTANCE',
  'CREATE_APPLICATION_INSTANCE',
  'DELETE_APPLICATION_INSTANCE',
  'DISABLE_APPLICATION_INSTANCE',
  'SAVE_APPLICATION_INSTANCE',
  'CHECK_APPLICATION_INSTANCE_AUTH',
];

export const Constants = wrapper(actions, requests);

export function getApplicationInstances(applicationId, page, column, direction, showPaid, search) {
  return {
    type: Constants.GET_APPLICATION_INSTANCES,
    method: Network.GET,
    url: `/api/applications/${applicationId}/application_instances`,
    params: {
      page,
      column,
      direction,
      show_paid: showPaid,
      search,
    }
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
  appInstanceClone.lti_config = JSON.parse(applicationInstance.lti_config || '{}');
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
  appInstanceClone.lti_config = JSON.parse(applicationInstance.lti_config || '{}');
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

export function disableApplicationInstance(applicationId, applicationInstanceId, disabledAt) {
  return {
    type   : Constants.DISABLE_APPLICATION_INSTANCE,
    method : Network.PUT,
    url    : `/api/applications/${applicationId}/application_instances/${applicationInstanceId}`,
    body   : {
      disabled_at: disabledAt,
    },
    applicationInstanceId,
  };
}

export function checkApplicationInstanceAuth(
  applicationId,
  applicationInstanceId,
  authenticationId,
) {
  return {
    type   : Constants.CHECK_APPLICATION_INSTANCE_AUTH,
    method : Network.GET,
    url    : `/api/applications/${applicationId}/application_instances/${applicationInstanceId}/check_auth?authentication_id=${authenticationId}`,
    applicationId,
    applicationInstanceId,
    authenticationId,
  };
}
