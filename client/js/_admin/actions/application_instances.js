import wrapper from '../../constants/wrapper';
import Network from '../../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_APPLICATION_INSTANCES',
];

export const Constants = wrapper(actions, requests);

export function getApplicationInstances(applicationId) {
  return {
    type   : Constants.GET_APPLICATION_INSTANCES,
    method : Network.GET,
    url    : `/api/applications/${applicationId}/application_instances`,
  };
}
