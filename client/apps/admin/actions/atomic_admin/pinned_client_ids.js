import _ from 'lodash';
import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_PINNED_CLIENT_IDS',
  'GET_PINNED_CLIENT_ID',
  'CREATE_PINNED_CLIENT_ID',
  'DELETE_PINNED_CLIENT_ID',
  // 'DISABLE_PINNED_CLIENT_ID',
  'UPDATE_PINNED_CLIENT_ID',
];

export const Constants = wrapper(actions, requests);

export function getPinnedClientIds(applicationInstanceId) {
  return {
    type: Constants.GET_PINNED_CLIENT_IDS,
    method: Network.POST,
    url: 'api/admin/atomic_tenant_client_id_strategy/search',
    params: {
      application_instance_id: applicationInstanceId
    }
  };
}

export function getPinnedClientId(pinnedClientIdId) {
  return {
    type   : Constants.GET_PINNED_CLIENT_ID,
    method : Network.GET,
    url    : `api/admin/atomic_tenant_client_id_strategy/${pinnedClientIdId}`,
  };
}

export function createPinnedClientId(pinnedClientId) {
  return {
    type   : Constants.CREATE_PINNED_CLIENT_ID,
    method : Network.POST,
    url    : `api/admin/atomic_tenant_client_id_strategy/`,
    body   : {
      ...pinnedClientId
    }
  };
}

export function updatePinnedClientId(pinnedClientIdId, pinnedClientId) {
  return {
    type: Constants.UPDATE_PINNED_CLIENT_ID,
    method: Network.PUT,
    url: `api/admin/atomic_tenant_client_id_strategy/${pinnedClientIdId}`,
    body: {
      ...pinnedClientId
    },
    pinnedClientIdId
  };
}

export function deletePinnedClientId(pinnedClientIdId) {
  return {
    type   : Constants.DELETE_PINNED_CLIENT_ID,
    method : Network.DEL,
    url    : `api/admin/atomic_tenant_client_id_strategy/${pinnedClientIdId}`,
    pinnedClientIdId
  };
}
