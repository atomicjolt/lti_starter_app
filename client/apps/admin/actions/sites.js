import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_SITES',
  'CREATE_SITE',
  'UPDATE_SITE',
  'DELETE_SITE',
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

export function updateSite(site) {
  return {
    type: Constants.UPDATE_SITE,
    method: Network.PUT,
    url: `api/sites/${site.id}`,
    body: {
      site,
    },
  };
}

export function deleteSite(siteId) {
  return {
    type: Constants.DELETE_SITE,
    method: Network.DEL,
    url: `api/sites/${siteId}`,
    siteId
  };
}
