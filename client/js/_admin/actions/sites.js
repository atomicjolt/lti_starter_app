import wrapper from '../../constants/wrapper';
import Network from '../../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_SITES',
  'CREATE_SITE',
];

export const Constants = wrapper(actions, requests);

export function getSites() {
  return {
    type   : Constants.GET_SITES,
    method : Network.GET,
    url    : 'api/sites',
  };
}

export function createSite(site) {
  return {
    type   : Constants.CREATE_SITE,
    method : Network.POST,
    url    : 'api/sites',
    body   : {
      site,
    },
  };
}
