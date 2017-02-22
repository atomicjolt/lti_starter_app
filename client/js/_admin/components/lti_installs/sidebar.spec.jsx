import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import Sidebar      from './sidebar';

describe('lti installs sidebar', () => {

  let result;
  let applicationName = 'applicationName';
  let accountName = 'accountName2';

  describe('should render sidebar', () => {
    beforeEach(() => {
      const props = {
        accounts: {
          0: {
            id: 1,
            name: 'accountName',
            sub_accounts: []
          }
        },
        application: {
          name: applicationName
        },
        saveApplicationInstance: () => {},
        canvasRequest: () => {},
        setAccountActive: () => {},
        activeAccounts: [],
        sites: {},
      };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Sidebar {...props} />
        </Stub>
      );
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });

    it('return the title name', () => {
      const title = TestUtils.findRenderedDOMComponentWithClass(result, 'c-tool__title');
      expect(title.textContent).toBe(applicationName);
    });

    it('return the title name', () => {
      const title = TestUtils.findRenderedDOMComponentWithClass(result, 'c-tool__instance');
      expect(title.textContent).toBe('Loading...');
    });

    it('return the button', () => {
      const button = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(button.textContent).toBe('Loading...');
    });

    it('return the button', () => {
      const dropdown = TestUtils.findRenderedDOMComponentWithClass(result, 'c-filter__dropdown');
      expect(dropdown).not.toBeNull();
      expect(dropdown.children.length).toBe(0);
    });
  });

  describe('should render sidebar not loading', () => {
    beforeEach(() => {
      const props = {
        accounts: {
          0: {
            name: 'accountName',
            sub_accounts: []
          },
          1: {
            name: accountName,
            sub_accounts: [
              {
                id: 1,
                name: 'subAccount1',
                sub_account: []
              },
              {
                id: 2,
                name: 'subAccount2',
                sub_account: []
              }
            ]
          }
        },
        application: {
          name: applicationName
        },
        saveApplicationInstance: () => {},
        canvasRequest: () => {},
        setAccountActive: () => {},
        activeAccounts: [],
        sites: {},
      };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Sidebar {...props} />
        </Stub>
      );
    });

    it('return the title name', () => {
      const title = TestUtils.findRenderedDOMComponentWithClass(result, 'c-tool__instance');
      expect(title.textContent).toBe(accountName);
    });

    it('return the button', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      expect(buttons[0].textContent).toBe(accountName);
    });

    it('return the button', () => {
      const dropdown = TestUtils.findRenderedDOMComponentWithClass(result, 'c-filter__dropdown');
      expect(dropdown).not.toBeNull();
      expect(dropdown.children.length).toBe(2);
    });

  });
});
