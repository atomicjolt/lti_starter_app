import Network from 'atomic-fuel/libs/constants/network';
import wrapper from 'atomic-fuel/libs/constants/wrapper';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'CREATE_LTI_LAUNCH',
];

export const Constants = wrapper(actions, requests);

export function createLtiLaunch(config, contentItemReturnURL, contentItem, settings) {
  return {
    method: Network.POST,
    type: Constants.CREATE_LTI_LAUNCH,
    url: 'api/lti_launches',
    body: {
      content_item_return_url: contentItemReturnURL,
      config,
      settings,
      content_item: contentItem,
    }
  };
}
