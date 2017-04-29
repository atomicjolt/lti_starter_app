import wrapper from '../../../libs/constants/wrapper';
import Network from '../../../libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'CREATE_CONTENT_ITEM_SELECTION',
];

export const Constants = wrapper(actions, requests);

export function getContentItemSelection(contentItemReturnURL, contentItem) {
  return {
    type: Constants.CREATE_CONTENT_ITEM_SELECTION,
    method: Network.POST,
    url: 'api/lti_content_item_selection',
    body: {
      content_item_return_url: contentItemReturnURL,
      content_item: JSON.stringify(contentItem)
    }
  };
}
