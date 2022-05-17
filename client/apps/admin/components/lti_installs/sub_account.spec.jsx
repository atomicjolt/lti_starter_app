import React from 'react';
import TestRenderer from 'react-test-renderer';
import SubAccount from './sub_account';

describe('should render nested accounts and active', () => {
  let result;
  let instance;
  let clicked;

  const accounts = {
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
  };

  const account = { id: 1, name: 'account_name', parent_account_id: null };
  const setAccountActive = () => { clicked = true; };
  const currentAccount = { id: 1 };

  beforeEach(() => {
    clicked = false;
    result = TestRenderer.create(<SubAccount
      accounts={accounts}
      account={account}
      setAccountActive={setAccountActive}
      currentAccount={currentAccount}
    />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('return correct amount of buttons', () => {
    const buttons = instance.findAllByType('button');
    expect(buttons.length).toBe(1);
  });

  it('return render the dropdown', () => {
    const button = instance.findByType('button');
    expect(button.props.children).toContain('account_name');
  });

  it('should not return the dropdown', () => {
    const dropdown = instance.findAllByProps({ className: 'i-dropdown' });
    expect(dropdown.length).toBe(1);
  });

  it('handles the button click', () => {
    expect(clicked).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(clicked).toBeTruthy();
  });
});
