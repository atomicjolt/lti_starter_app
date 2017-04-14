import React from 'react';
import TestUtils from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import Helper from '../../../../specs_support/helper';
import SiteRow from './site_row';

describe('sites list row', () => {
  let result;

  const props = {
    site: { url: 'http://www.example.com' },
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <table><tbody>
          <SiteRow {...props} />
        </tbody></table>
      </Provider>
    );
  });

  it('renders the site url', () => {
    const tr = TestUtils.findRenderedDOMComponentWithTag(result, 'tr');
    expect(tr.textContent).toContain('example.com');
  });
});
