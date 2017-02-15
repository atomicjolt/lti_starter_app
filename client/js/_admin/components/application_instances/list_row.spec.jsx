import _            from 'lodash';
import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import Helper       from '../../../../specs_support/helper';
import ListRow      from './list_row';

describe('application instances list row', () => {

  let result;
  let deleted = false;

  const props = {
    delete: () => { deleted = true; },
    lti_key: 'lti-key',
    domain: 'www.example.com',
    id: 2,
    application_id: 23,
    site: { url: 'http://www.example.com' },
    settings: {
      lti_key: 'lti-key',
      user_canvas_domains: [''],
    }
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <table><tbody>
          <ListRow {...props} />
        </tbody></table>
      </Provider>
    );
  });

  it('renders the site url', () => {
    const a = TestUtils.findRenderedDOMComponentWithTag(result, 'a');
    expect(a.textContent).toContain('Example');
  });

  it('deletes the application instance', () => {
    const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
    const deleteButton = _.find(buttons, { className: 'c-delete' });
    TestUtils.Simulate.click(deleteButton);
    expect(deleted).toBe(true);
  });


});
