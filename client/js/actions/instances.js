import wrapper from '../constants/wrapper';
import Network from '../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_INSTANCES',
];

export const Constants = wrapper(actions, requests);

export function getInstructureInstances(applicationId) {
  return {
    type   : Constants.GET_INSTANCES,
    method : Network.GET,
    url    : '/admin/app_instances',
    params :  { application_id: applicationId }
  };
}
