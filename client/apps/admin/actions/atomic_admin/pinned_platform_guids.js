import _ from 'lodash';
import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_PINNED_PLATFORM_GUIDS',
  'GET_PINNED_PLATFORM_GUID',
  'CREATE_PINNED_PLATFORM_GUID',
  'DELETE_PINNED_PLATFORM_GUID',
  // 'DISABLE_PINNED_PLATFORM_GUID',
  'UPDATE_PINNED_PLATFORM_GUID',
];

export const Constants = wrapper(actions, requests);

export function getPinnedPlatformGuids(applicationInstanceId) {
  return {
    type: Constants.GET_PINNED_PLATFORM_GUIDS,
    method: Network.POST,
    url: 'api/admin/atomic_tenant_platform_guid_strategy/search',
    params: {
      application_instance_id: applicationInstanceId
    }
  };
}

export function getPinnedPlatformGuid(pinnedPlatformGuidId) {
  return {
    type   : Constants.GET_PINNED_PLATFORM_GUID,
    method : Network.GET,
    url    : `api/admin/atomic_tenant_platform_guid_strategy/${pinnedPlatformGuidId}`,
  };
}

export function createPinnedPlatformGuid(pinnedPlatformGuId) {
  return {
    type   : Constants.CREATE_PINNED_PLATFORM_GUID,
    method : Network.POST,
    url    : 'api/admin/atomic_tenant_platform_guid_strategy/',
    body   : {
      ...pinnedPlatformGuId
    }
  };
}

export function updatePinnedPlatformGuid(pinnedPlatformGuidId, pinnedPlatformGuid) {
  return {
    type: Constants.UPDATE_PINNED_PLATFORM_GUID,
    method: Network.PUT,
    url: `api/admin/atomic_tenant_platform_guid_strategy/${pinnedPlatformGuidId}`,
    body: {
      ...pinnedPlatformGuid
    },
    pinnedPlatformGuidId
  };
}

export function deletePinnedPlatformGuid(pinnedPlatformGuidId) {
  return {
    type   : Constants.DELETE_PINNED_PLATFORM_GUID,
    method : Network.DEL,
    url    : `api/admin/atomic_tenant_platform_guid_strategy/${pinnedPlatformGuidId}`,
    pinnedPlatformGuidId
  };
}
