import React from 'react';
import TestRenderer from 'react-test-renderer';
import Accounts from './accounts';

describe('lti installs accounts', () => {
  let result;

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
    result = TestRenderer.create(<Accounts {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
