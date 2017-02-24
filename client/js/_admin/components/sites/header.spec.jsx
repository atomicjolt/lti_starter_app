import React from 'react';
import TestUtils from 'react-addons-test-utils';
import Stub from '../../../../specs_support/stub';
import Header from './header';

describe('sites header', () => {
  let result;
  const props = {
    newSite: () => {},
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <Header {...props} />
      </Stub>
    );
  });

  it('renders the header', () => {
    const h1 = TestUtils.findRenderedDOMComponentWithTag(result, 'h1');
    expect(h1.textContent).toContain('Sites');
  });

  it('renders new site button', () => {
    const button = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
    expect(button.textContent).toBe('New Site');
  });

});
