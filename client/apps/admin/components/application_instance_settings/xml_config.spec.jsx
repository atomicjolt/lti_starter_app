import React from 'react';
import { Provider } from 'react-redux';
import TestRenderer from 'react-test-renderer';

import XmlConfig from './xml_config';
import configureStore from 'redux-mock-store';

const mockStore = configureStore([]);

const applicationInstance = {
  id: 1,
};

const store = mockStore({
  applicationInstances: [
    applicationInstance,
  ],
});

describe('XmlConfig', () => {
  it('renders the XmlConfig component', () => {
    const params = {
      applicationId: "1",
      applicationInstanceId: "1",
    };

    const result = TestRenderer.create(
      <Provider store={store}>
        <XmlConfig params={params}/>
      </Provider> 
    );
    expect(result).toMatchSnapshot();
  });
});
