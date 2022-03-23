import React from 'react';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import TestRenderer from 'react-test-renderer';
import Index from './index';

jest.mock('../../libs/assets');

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
      }
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
    const headings = instance.findAllByType('h3');
    const accountHeading = headings.find((h) => h.props.children === 'Root');
    expect(accountHeading).toBeDefined();
  });
});
