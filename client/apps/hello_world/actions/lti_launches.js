import Network    from '../../../libs/constants/network';
import wrapper    from '../../../libs/constants/wrapper';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'CREATE_LTI_LAUNCH',
];

export const Constants = wrapper(actions, requests);

export function createLtiLaunch(config, contentItemReturnURL, contentItem) {
  return {
    method: Network.POST,
    type: Constants.CREATE_LTI_LAUNCH,
    url: 'api/lti_launches',
    body: {
      content_item_return_url: contentItemReturnURL,
      config,
      content_item: contentItem,
    }
  };
}
