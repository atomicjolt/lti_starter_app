import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import Index from './index';

const ltiInstallKeys = [{ ltiInstallKeys: {} }];
const applications = {};
const totalPages = 10;

const mockStore = configureStore([]);
const store = mockStore({
  ltiInstallKeys,
  applications,
  totalPages,
  settings: {
    sign_out_url: 'https://www.example.com',
  },
});

jest.mock('../../libs/assets');
describe('application instances index', () => {
  let result;
  const params = {
    applicationId: 'id',
  };
  // const totalPages = 10;

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <Index
          params={params}
        />
      </Provider>);
  });

  it('loads the lti install keys', () => {
    expect(ltiInstallKeys).toBeTruthy();
  });

  it('renders table tags', () => {
    expect(result).toBeDefined();
  });
});
