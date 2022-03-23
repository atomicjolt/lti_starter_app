import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Index } from './index';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {
    sign_out_url: 'https://www.example.com',
  },
});

jest.mock('../../libs/assets');
describe('application instances index', () => {
  let result;
  let props;
  let applicationInstances = false;
  const sitesData = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  beforeEach(() => {
    props = {
      applicationInstances: [{ applicationInstances: {} }],
      getApplicationInstances: () => { applicationInstances = true; },
      createApplicationInstance: () => {},
      saveApplicationInstance: () => {},
      deleteApplicationInstance: () => {},
      sites: sitesData,
      applications: {},
      params: {
        applicationId: 'id',
      },
      settings: {
        canvas_callback_url: 'https://www.example.com'
      },
      canvasOauthURL: 'https://www.example.com',
      disableApplicationInstance: () => {},
      totalPages: 10,
    };
    result = TestRenderer.create(
      <Provider store={store}>
        <Index {...props} />
      </Provider>
    );
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('loads the assessments', () => {
    expect(applicationInstances).toBeTruthy();
  });
});
