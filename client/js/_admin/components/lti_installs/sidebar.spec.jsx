import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import Sidebar      from './sidebar';

describe('lti installs sidebar', () => {

  let result;
  let canvasRequest = false;
  let activeAccounts = false;
  let saveApplicationInstance = false;
  let application_name = 'application_name';

  describe('should render sidebar', () => {
    beforeEach(() => {
      const props = {
        accounts: {
          0: {
            id: 1,
            name: 'account_name',
            sub_accounts: []
          }
        },
        application: {
          name: application_name
        },
        saveApplicationInstance: () => { saveApplicationInstance = true; },
        canvasRequest: () => { canvasRequest = true; },
        setAccountActive: () => { activeAccounts = true; },
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
      expect(title.textContent).toBe(application_name);
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
            name: 'account_name',
            sub_accounts: []
          },
          1: {
            name: 'account_name2',
            sub_accounts: [
              {
                id: 1,
                name: 'sub_account1',
                sub_account: []
              },
              {
                id: 2,
                name: 'sub_account2',
                sub_account: []
              }
            ]
          }
        },
        application: {
          name: application_name
        },
        saveApplicationInstance: () => { saveApplicationInstance = true; },
        canvasRequest: () => { canvasRequest = true; },
        setAccountActive: () => { activeAccounts = true; },
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
      expect(title.textContent).toBe('account_name2');
    });

    it('return the button', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      expect(buttons[0].textContent).toBe('account_name2');
    });

    it('return the button', () => {
      const dropdown = TestUtils.findRenderedDOMComponentWithClass(result, 'c-filter__dropdown');
      expect(dropdown).not.toBeNull();
      expect(dropdown.children.length).toBe(2);
    });

  });
});
