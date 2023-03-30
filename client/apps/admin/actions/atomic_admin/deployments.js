import _ from 'lodash';
import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_DEPLOYMENTS',
  'GET_DEPLOYMENT',
  'CREATE_DEPLOYMENT',
  'DELETE_DEPLOYMENT',
  // 'DISABLE_DEPLOYMENT',
  'UPDATE_DEPLOYMENT',
];

export const Constants = wrapper(actions, requests);

export function getDeployments(applicationInstanceId) {
  return {
    type: Constants.GET_DEPLOYMENTS,
    method: Network.POST,
    url: 'api/admin/atomic_tenant_deployment/search',
    params: {
      application_instance_id: applicationInstanceId
    }
  };
}

export function getDeployment(deploymentId) {
  return {
    type   : Constants.GET_DEPLOYMENT,
    method : Network.GET,
    url    : `api/admin/atomic_tenant_deployment/${deploymentId}`,
  };
}

export function createDeployment(deployment) {
  return {
    type   : Constants.CREATE_DEPLOYMENT,
    method : Network.POST,
    url    : `api/admin/atomic_tenant_deployment/`,
    body   : {
      ...deployment
    }
  };
}

export function updateDeployment(deploymentId, deployment) {
  return {
    type: Constants.UPDATE_DEPLOYMENT,
    method: Network.PUT,
    url: `api/admin/atomic_tenant_deployment/${deploymentId}`,
    body: {
      ...deployment
    },
    deploymentId
  };
}

export function deleteDeployment(deploymentId) {
  return {
    type   : Constants.DELETE_DEPLOYMENT,
    method : Network.DEL,
    url    : `api/admin/atomic_tenant_deployment/${deploymentId}`,
    deploymentId
  };
}
