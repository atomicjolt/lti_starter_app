import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import LtiAdvantageSettings from './lti_advantage_settings';

const mockStore = configureStore([

]);

const applicationInstance = {
  id: '2',
  application_id: '1',
  canvas_lti_advantage_config_url: 'https://canvas.instructure.com/',
};

const store = mockStore({
  applicationInstances: {
    applicationInstances: [applicationInstance],
  },
});

describe('LtiAdvantageSettings', () => {
  it('renders the LtiAdvantageSettings component', () => {
    const params = {
      applicationId: '1',
      applicationInstanceId: '2',
    };

    const result = TestRenderer.create(
      <Provider store={store}>
        <LtiAdvantageSettings params={params} />
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
