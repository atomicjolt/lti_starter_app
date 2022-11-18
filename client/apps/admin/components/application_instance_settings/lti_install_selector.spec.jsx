import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import LtiInstallSelector from './lti_install_selector';

const mockStore = configureStore([]);
const store = mockStore({
  ltiInstallKeys: {},
});

describe('LtiInstallSelector', () => {
  it('renders the LtiInstallSelector component', () => {
    const result = TestRenderer.create(
      <Provider store={store}>
        <LtiInstallSelector/>
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
