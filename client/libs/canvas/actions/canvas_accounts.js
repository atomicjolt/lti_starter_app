import wrapper from '../constants/wrapper';
import Network from '../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_ALL_ACCOUNTS',
];

export const Constants = wrapper(actions, requests);

export function getAllAccounts(oauthConsumerKey) {
  return {
    type: Constants.GET_ALL_ACCOUNTS,
    method: Network.GET,
    url: 'api/canvas_accounts',
    params: {
      oauth_consumer_key: oauthConsumerKey
    }
  };
}
