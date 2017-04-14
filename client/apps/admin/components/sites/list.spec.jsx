import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import Helper from '../../../../specs_support/helper';
import Stub from '../../../../specs_support/stub';
import List from './list';

describe('sites list', () => {
  let result;
  const sites = {
    1: {
      id: 1,
      url: 'bfcoder.com'
    },

    2: {
      id: 2,
      url: 'atomicjolt.com'
    }
  };
  const props = {
    sites,
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Stub>
          <List {...props} />
        </Stub>
      </Provider>
    );
  });

  it('renders the list with header values', () => {
    const thead = TestUtils.findRenderedDOMComponentWithTag(result, 'thead');
    expect(thead.textContent).toContain('URL');
    expect(thead.textContent).toContain('SETTINGS');
    expect(thead.textContent).toContain('DELETE');
  });

  it('renders all sites', () => {
    const trs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'tr');
    // 1 in thead, 2 in tbody, 3 total
    expect(trs.length).toBe(3);
  });
});
