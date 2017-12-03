import * as LtiLaunches from './lti_launches';

describe('the lti launches actions', () => {
  it('handles the createLtiLaunch', () => {
    const config = {};
    const contentItemReturnURL = 'thisisthetestURL';
    const contentItem = {};
    const settings = {};
    const expectedAction = {
      method: 'post',
      type: 'CREATE_LTI_LAUNCH',
      url: 'api/lti_launches',
      body: {
        content_item_return_url: contentItemReturnURL,
        config,
        settings,
        content_item: contentItem,
      },
    };
    expect(LtiLaunches.createLtiLaunch(
      config,
      contentItemReturnURL,
      contentItem,
      settings,
    )).toEqual(expectedAction);
  });
});
