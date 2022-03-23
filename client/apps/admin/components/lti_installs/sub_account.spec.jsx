import React from 'react';
import TestRenderer from 'react-test-renderer';
import SubAccount from './sub_account';

describe('should render nested accounts and active', () => {
  let result;
  let instance;
  let clicked;

  beforeEach(() => {
    clicked = false;
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
      setAccountActive: () => { clicked = true; },
      currentAccount: { id: 1 }
    };
    result = TestRenderer.create(<SubAccount {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('return correct amount of buttons', () => {
    result.setState({ open: true });
    const buttons = instance.findByType('button');
    expect(buttons.length).toBe(1);
  });

  it('return render the dropdown', () => {
    const button = instance.findByType('button');
    expect(button.props().children).toContain('account_name');
  });

  it('should not return the dropdown', () => {
    const dropdown = instance.findByType('.i-dropdown');
    expect(dropdown.length).toBe(1);
  });

  it('handles the button click', () => {
    expect(clicked).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(clicked).toBeTruthy();
  });
});
