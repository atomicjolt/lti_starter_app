import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import Index from './index';

const application = {
  id: 1,
  name: 'test application',
};

const site = {
  url: "https://www.example.com",
};

const applicationInstance = {
  id: 1,
  nickname: 'a test application instance',
  site: site,
};

const params = {
  applicationId: application.id,
  applicationInstanceId: applicationInstance.id,
};

const applications = {};
applications[application.id] = application;

const mockStore = configureStore([]);
const store = mockStore({
  settings: {
    user_edit_url: 'https://www.example.com',
  },
  applicationInstances: {
    newApplicationInstance: {},
    applicationInstance: applicationInstance,
  },
  application: application,
  applications: applications,
  location: {},
});

describe('Index', () => {
  it('renders the Index component', () => {
    const result = TestRenderer.create(
      <Provider store={store}>
        <Index params={params}/>
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
