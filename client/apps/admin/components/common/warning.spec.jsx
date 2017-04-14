import React from 'react';
import TestUtils from 'react-dom/test-utils';
import Stub from '../../../../specs_support/stub';
import Warning from './warning';

describe('warning', () => {

  let result;
  const props = {
    text: 'bfcoder was here',
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <Warning {...props} />
      </Stub>
    );
  });

  it('renders the warning', () => {
    const warning = TestUtils.scryRenderedDOMComponentsWithTag(result, 'div');
    expect(warning[0].textContent).toContain('bfcoder was here');
  });
});
