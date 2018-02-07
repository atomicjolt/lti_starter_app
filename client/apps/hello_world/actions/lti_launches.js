import Network from 'atomic-fuel/libs/constants/network';
import wrapper from 'atomic-fuel/libs/constants/wrapper';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'CREATE_LTI_LAUNCH',
];

export const Constants = wrapper(actions, requests);

export function createLtiLaunch(
  config,
  contentItemReturnURL,
  contentItem,
  contextId,
  toolConsumerInstanceGuid,
) {
  return {
    method: Network.POST,
    type: Constants.CREATE_LTI_LAUNCH,
    url: 'api/lti_launches',
    body: {
      content_item_return_url: contentItemReturnURL,
      content_item: contentItem,
      lti_launch: {
        config,
        context_id: contextId,
        tool_consumer_instance_guid: toolConsumerInstanceGuid,
      }
    }
  };
}
