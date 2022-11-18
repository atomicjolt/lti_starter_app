import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import GeneralSettings from './general_settings';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {},
});

describe('GeneralSettings', () => {
  it('renders the GeneralSettings component', () => {

    const languagesSupported = [];
    const params = {
      applicationId: '3',
      applicationInstanceId: '3',
    };
    const loading = false;
    const loaded = true;
    const sites = {
      3: {
        id: 3,
        url: 'https://www.example.com',
      }
    };
    const applicationInstance = {
      id: 3,
      application_id: 3,
      site: {
        id: 3,
      },
      created_at: '11/17/2022',
    };
    const applicationInstances = [
      applicationInstance,
    ];

    const result = TestRenderer.create(
      <Provider store={store}>
        <GeneralSettings
          languagesSupported={languagesSupported}
          params={params}
          loading={loading}
          loaded={loaded}
          sites={sites}
          applicationInstances={applicationInstances}
        />
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
