import React          from 'react';
import TestUtils      from 'react-dom/test-utils';
import SubAccount     from './sub_account';

describe('should render nested accounts and active', () => {
  let result;
  beforeEach(() => {
    const props = {
      accounts: {
        1: {
          id: 1,
          name: 'account_name',
          parent_account_id: null
        },
        2: {
          id: 1,
          name: 'account_name1',
          parent_account_id: 1
        },
        3: {
          id: 2,
          name: 'account_name2',
          parent_account_id: 1
        }
      },
      account: { id: 1, name: 'account_name', parent_account_id: null },
      setAccountActive: () => {},
      currentAccount: { id: 1 }
    };
    result = TestUtils.renderIntoDocument(
      <SubAccount {...props} />
    );
  });

  it('return correct amount of buttons', () => {
    result.setState({ open: true });
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

});
