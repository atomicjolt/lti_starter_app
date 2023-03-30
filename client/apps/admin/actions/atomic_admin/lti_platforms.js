import _ from 'lodash';
import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_PLATFORMS',
  'GET_PLATFORM',
  'CREATE_PLATFORM',
  'DELETE_PLATFORM',
  // 'DISABLE_PLATFORM',
  'UPDATE_PLATFORM',
];

export const Constants = wrapper(actions, requests);

export function getPlatforms(page) {
  return {
    type: Constants.GET_PLATFORMS,
    method: Network.GET,
    url: 'api/admin/atomic_lti_platform',
    params: {
      // page
    }
  };
}

export function getPlatform(platformId) {
  return {
    type   : Constants.GET_PLATFORM,
    method : Network.GET,
    url    : `api/admin/atomic_lti_platform/${platformId}`,
  };
}

export function createPlatform(platform) {
  return {
    type   : Constants.CREATE_PLATFORM,
    method : Network.POST,
    url    : `api/admin/atomic_lti_platform/`,
    body   : {
      // iss,
      // jwks_url: jwksUrl,
      // token_url: tokenUrl,
      // oidc_url: oidcUrl
      ...platform
    }
  };
}

export function updatePlatform(platformId, platform) {
  return {
    type: Constants.UPDATE_PLATFORM,
    method: Network.PUT,
    url: `api/admin/atomic_lti_platform/${platformId}`,
    body: {
      ...platform
    },
    platformId
  };
}

export function deletePlatform(platformId) {
  return {
    type   : Constants.DELETE_PLATFORM,
    method : Network.DEL,
    url    : `api/admin/atomic_lti_platform/${platformId}`,
    platformId
  };
}
