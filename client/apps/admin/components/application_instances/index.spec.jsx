import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import Index from './index';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {
    sign_out_url: 'https://www.example.com',
  },
  applicationInstances: {
    applicationInstances: [],
  },
  applications: {},
  loadingInstances: {},
  sites: { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } },
  totalPages: 10,
  canvasOauthURL: 'https://www.example.com',
});

jest.mock('../../libs/assets');
describe('application instances index', () => {
  let result;
  let instance;
  const params = {
    applicationId: 'id',
  };

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <Index
          params={params}
        />
      </Provider>
    );
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('loads the assessments', () => {
    expect(instance.findByProps({ className: 'c-table-container' })).toBeDefined();
  });
});
