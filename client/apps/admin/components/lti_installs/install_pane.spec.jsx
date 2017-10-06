import React from 'react';
import TestUtils from 'react-dom/test-utils';
import Stub from '../../../../specs_support/stub';
import { InstallPane } from './install_pane';

describe('install pane', () => {
  let result;

  const props = {
    canvasRequest: () => {},
    loadingCourses: {},
    applicationInstance: {},
    courses: [],
    account: {
      installCount: 0,
    },
    loadExternalTools: () => {},
    onlyShowInstalled: false,
  };

  describe('basic instances', () => {
    beforeEach(() => {
      result = TestUtils.renderIntoDocument(
        <Stub>
          <InstallPane {...props} />
        </Stub>
      );
    });

    it('renders the install pane with account installs for basic', () => {
      const button = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(button.textContent).toContain('Install Into Account');
    });

    it('renders the install pane with course installs for basic', () => {
      const input = TestUtils.findRenderedDOMComponentWithTag(result, 'input');
      expect(input.placeholder).toContain('Search...');
    });
  });

});
