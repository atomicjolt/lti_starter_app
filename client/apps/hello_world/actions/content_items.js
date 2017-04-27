import wrapper from '../../../libs/constants/wrapper';
import Network from '../../../libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_CONTENT_ITEM_SELECTION',
];

export const Constants = wrapper(actions, requests);

export function getContentItemSelection(contentItemReturnURL, contentItem) {
  return {
    type: Constants.GET_CONTENT_ITEM_SELECTION,
    method: Network.GET,
    url: 'api/lti_content_item_selection',
    params: {
      content_item_return_url: contentItemReturnURL,
      content_item: JSON.stringify(contentItem)
    }
  };
}
