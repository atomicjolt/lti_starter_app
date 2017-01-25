import wrapper from '../../constants/wrapper';
import Network from '../../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_APPLICATIONS',
];

export const Constants = wrapper(actions, requests);

export function getApplications() {
  return {
    type   : Constants.GET_APPLICATIONS,
    method : Network.GET,
    url    : 'api/applications',
  };
}
