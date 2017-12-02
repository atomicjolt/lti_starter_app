import * as ContentItems from './content_items';

describe('the content items actions', () => {
  it('handles the getContentItemSelection action', () => {
    const contentItemReturnURL = 'thisisthetesturl';
    const contentItem = {};
    const expectedAction = {
      type: 'CREATE_CONTENT_ITEM_SELECTION',
      method: 'post',
      url: 'api/lti_content_item_selection',
      body: {
        content_item_return_url: contentItemReturnURL,
        content_item: '{}',
      },
    };
    expect(ContentItems.getContentItemSelection(
      contentItemReturnURL,
      contentItem,
    )).toEqual(expectedAction);
  });
});
