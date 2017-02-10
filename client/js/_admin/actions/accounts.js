import wrapper from '../../constants/wrapper';
import Network from '../../constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_CANVAS_ACCOUNTS',
];

export const Constants = wrapper(actions, requests);

export function getCanvasAccounts() {
  return {
    type: Constants.GET_CANVAS_ACCOUNTS,
    method: Network.GET,
    url: 'api/canvas_accounts',
  };
}
