import React        from 'react';
import TestUtils    from 'react-dom/test-utils';
import Accounts     from './accounts';

describe('lti installs accounts', () => {

  let result;

  describe('should render basic inactive subaccount', () => {
    beforeEach(() => {
      const props = {
        accounts: {
          1: {
            id: 1,
            name: 'account_name',
            parent_account_id: null
          }
        },
        setAccountActive: () => {},
        currentAccount: null,
      };
      result = TestUtils.renderIntoDocument(
        <Accounts {...props} />
      );
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });

    it('return the list', () => {
      const dropdowns = TestUtils.scryRenderedDOMComponentsWithClass(result, 'c-filter__item');
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


});
