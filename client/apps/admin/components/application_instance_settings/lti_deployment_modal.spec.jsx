import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import LtiDeploymentModal from './lti_deployment_modal';

const mockStore = configureStore([]);
const store = mockStore({});

describe('LtiDeploymentModal', () => {
  it('renders the LtiDeploymentModal component', () => {
    const result = TestRenderer.create(
      <Provider store={store}>
        <LtiDeploymentModal />
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
