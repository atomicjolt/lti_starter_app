import React from 'react';
import { shallow } from 'enzyme';
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
    result = shallow(<Accounts {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
