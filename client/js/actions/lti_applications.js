import wrapper from '../constants/wrapper';
import Network from '../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_LTI_APPLICATIONS',
];

export const Constants = wrapper(actions, requests);

export function getInstructureInstances() {
  return {
    type   : Constants.GET_LTI_APPLICATIONS,
    method : Network.GET,
    url    : 'api/lti_applications',
  };
}
