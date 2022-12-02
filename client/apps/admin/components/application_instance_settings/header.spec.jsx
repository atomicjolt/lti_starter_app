import React from 'react';
import { Provider } from 'react-redux';
import TestRenderer from 'react-test-renderer';

import Header from './header';
import configureStore from 'redux-mock-store';

const mockStore = configureStore([]);

const settings =  {
  sign_out_url: 'https://www.example.com',
};

const store = mockStore({
  applicationInstances: {
    newApplicationInstance: {
    }
  },
  settings,
});

describe('Header', () => {

  const applicationInstance = {
    site: {},
  };
  const application = {};

  it('renders the Header component', () => {
    const result = TestRenderer.create(
      <Provider store={store}>
        <Header applicationInstance={applicationInstance} application={application}/>
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
