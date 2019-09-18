import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'CREATE_DEEP_LINK',
];

export const Constants = wrapper(actions, requests);

export function createDeepLink(type) {
  return {
    type: Constants.CREATE_DEEP_LINK,
    method: Network.POST,
    url: 'api/lti_deep_link_jwt',
    body: {
      type,
    }
  };
}
