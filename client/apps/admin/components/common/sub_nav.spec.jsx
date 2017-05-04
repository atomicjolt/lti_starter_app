import React from 'react';
import TestUtils from 'react-dom/test-utils';
import _ from 'lodash';
import Stub from '../../../../specs_support/stub';
import SubNav from './sub_nav';

describe('sub nav', () => {
  let result;

  describe('has sites', () => {
    beforeEach(() => {
      const sites = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <SubNav sites={sites} />
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

  describe("doesn't have sites", () => {
    beforeEach(() => {
      const sites = {};
      result = TestUtils.renderIntoDocument(
        <Stub>
          <SubNav sites={sites} />
        </Stub>
      );
    });

    it('renders Sites', () => {
      const links = TestUtils.scryRenderedDOMComponentsWithTag(result, 'a');
      const link = _.find(links, { textContent: 'Sites ! Setup Required' });
      expect(link).toBeDefined();
    });
  });
});
