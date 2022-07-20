import React from 'react';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import TestRenderer from 'react-test-renderer';
import Index from './index';

const mockStore = configureStore([]);
const applicationId = '123';
const applicationInstanceId = '4847';

const store = mockStore({
  settings: {
    sign_out_url: 'https://www.example.com',
  },
  applicationInstances: {
    applicationInstances: [],
  },
  accounts: {
    accounts: {
      1234: {
        id: 1234,
        parent_account_id: null,
        name: 'paul',
      },
      2345: {
        id: 2345,
        parent_account_id: 1234,
        name: 'joe',
      },
    }
  },
  applications: {},
  courses: [{}],
  applicationInstance: {},
  loadingCourses: {},
  loadingAccounts: false,
  sites: {},
});

describe('the index component', () => {
  let result;
  let instance;

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <Index params={{
          applicationId,
          applicationInstanceId,
        }}
        />
      </Provider>
    );
    instance = result.root;
  });
  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('sets the active account', () => {
    const buttons = instance.findAllByType('button');
    const button = buttons[1];
    const name = button.props.children[1];
    expect(name).toEqual('paul');
  });
});
