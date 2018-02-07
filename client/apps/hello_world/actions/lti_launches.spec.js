import * as LtiLaunches from './lti_launches';

describe('the lti launches actions', () => {
  it('handles the createLtiLaunch', () => {
    const config = {};
    const contentItemReturnURL = 'thisisthetestURL';
    const contentItem = {};
    const contextId = 'randomvaluethattypicallyrepresentsacourse';
    const toolConsumerInstanceGuid = 'valuethatidentifiestheinstanceofthelms';
    const expectedAction = {
      method: 'post',
      type: 'CREATE_LTI_LAUNCH',
      url: 'api/lti_launches',
      body: {
        content_item_return_url: contentItemReturnURL,
        content_item: contentItem,
        lti_launch: {
          context_id: contextId,
          tool_consumer_instance_guid: toolConsumerInstanceGuid,
          config,
        }
      },
    };
    expect(LtiLaunches.createLtiLaunch(
      config,
      contentItemReturnURL,
      contentItem,
      contextId,
      toolConsumerInstanceGuid,
    )).toEqual(expectedAction);
  });
});
