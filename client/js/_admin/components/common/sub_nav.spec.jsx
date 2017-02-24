import React from 'react';
import TestUtils from 'react-addons-test-utils';
import _ from 'lodash';
import Stub from '../../../../specs_support/stub';
import SubNav from './sub_nav';

describe('sub nav', () => {
  let result;

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <SubNav />
      </Stub>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders LTI Tools', () => {
    const links = TestUtils.scryRenderedDOMComponentsWithTag(result, 'a');
    const link = _.find(links, { textContent: 'LTI Tools' });
    expect(link).toBeDefined();
  });

  it('renders Sites', () => {
    const links = TestUtils.scryRenderedDOMComponentsWithTag(result, 'a');
    const link = _.find(links, { textContent: 'Sites' });
    expect(link).toBeDefined();
  });
});
