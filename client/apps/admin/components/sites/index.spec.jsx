import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import Helper from '../../../../specs_support/helper';
import { Index } from './index';

describe('sites index', () => {
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
        <Index {...props} />
      </Provider>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });
});
