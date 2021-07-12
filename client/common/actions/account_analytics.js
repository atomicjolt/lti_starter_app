import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

const actions = [];
const requests = [
  'GET_UNIQUE_USERS',
];

export const Constants = wrapper(actions, requests);


export function getUniqueUsers(accountId, tenant) {
  if (accountId === '1' || tenant) {
    return {
      type: Constants.GET_UNIQUE_USERS,
      method: Network.GET,
      url: '/api/account_analytics/',
      isRoot: true,
      params:{
        tenant
      }
    };
  }
  return {
    type: Constants.GET_UNIQUE_USERS,
    isRoot: false,
  };
}
