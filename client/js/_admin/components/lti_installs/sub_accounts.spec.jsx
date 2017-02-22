import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import SubAccounts  from './sub_accounts';

describe('lti installs sub accounts', () => {

  let result;

  describe('should render basic inactive subaccount', () => {
    beforeEach(() => {
      const props = {
        accounts: [
          {
            id: 1,
            name: 'account_name',
            sub_accounts: []
          }
        ],
        setAccountActive: () => { activeAccounts = true; },
        activeAccounts: []
      };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <SubAccounts {...props} />
        </Stub>
      );
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });

    it('return the list', () => {
      const dropdowns = TestUtils.scryRenderedDOMComponentsWithClass(result, 'c-filter__dropdown');
      expect(dropdowns.length).toBe(1);
      expect(dropdowns[0].children.length).toBe(1);
    });

    it('should not return the dropdown', () => {
      const dropdown = TestUtils.scryRenderedDOMComponentsWithClass(result, 'i-dropdown');
      expect(dropdown.length).toBe(0);
    });

    it('return the button', () => {
      const button = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(button.textContent).toBe('account_name');
    });
  });

  describe('should render nested subaccounts and active', () => {
    beforeEach(() => {
      const props = {
        accounts: [
          {
            id: 1,
            name: 'account_name',
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
        ],
        setAccountActive: () => { activeAccounts = true; },
        activeAccounts: [
          {
            id: 1
          }
        ]
      };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <SubAccounts {...props} />
        </Stub>
      );
    });

    it('return correct amount of buttons', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      expect(buttons.length).toBe(3);
    });

    it('return render the dropdown', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      expect(buttons[0].textContent).toBe('account_name');
    });

    it('should not return the dropdown', () => {
      const dropdown = TestUtils.scryRenderedDOMComponentsWithClass(result, 'i-dropdown');
      expect(dropdown.length).toBe(1);
    });

    it('return the correct amount of lists', () => {
      const lists = TestUtils.scryRenderedDOMComponentsWithClass(result, 'c-filter__dropdown');
      expect(lists.length).toBe(3);
    });

  });
});
