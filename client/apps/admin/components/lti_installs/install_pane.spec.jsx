import React from 'react';
import TestUtils from 'react-dom/test-utils';
import Stub from '../../../../specs_support/stub';
import InstallPane from './install_pane';

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
      props.applicationInstance.lti_type = 'basic';
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

  describe('account_navigation instances', () => {
    beforeEach(() => {
      props.applicationInstance.lti_type = 'account_navigation';
      result = TestUtils.renderIntoDocument(
        <Stub>
          <InstallPane {...props} />
        </Stub>
      );
    });

    it('renders the install pane with account installs for basic', () => {
      const button = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(button.textContent).toContain(name);
    });

    it('renders the install pane without course installs for account_navigation', () => {
      const input = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
      expect(input.length).toBe(0);
    });

  });

  describe('course_navigation instances', () => {
    beforeEach(() => {
      props.applicationInstance.lti_type = 'course_navigation';
      result = TestUtils.renderIntoDocument(
        <Stub>
          <InstallPane {...props} />
        </Stub>
      );
    });

    it('renders the install pane with course installs for course_navigation', () => {
      const input = TestUtils.findRenderedDOMComponentWithTag(result, 'input');
      expect(input.placeholder).toContain('Search...');
    });

    it('renders the install pane with account installs for course_navigation', () => {
      const button = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      expect(button.length).toBe(1);
    });
  });

  describe('wysiwyg_button instances', () => {
    beforeEach(() => {
      props.applicationInstance.lti_type = 'wysiwyg_button';
      result = TestUtils.renderIntoDocument(
        <Stub>
          <InstallPane {...props} />
        </Stub>
      );
    });

    it('renders the install pane with account installs for wysiwyg_button', () => {
      const button = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(button.textContent).toContain('Install Into Account');
    });

    it('renders the install pane with course installs for wysiwyg_button', () => {
      const input = TestUtils.findRenderedDOMComponentWithTag(result, 'input');
      expect(input.placeholder).toContain('Search...');
    });
  });
});
