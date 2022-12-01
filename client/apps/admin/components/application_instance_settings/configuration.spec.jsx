import React from 'react';
import { Provider } from 'react-redux';
import TestRenderer from 'react-test-renderer';
import configureStore from 'redux-mock-store';

import Configuration from './configuration';

const mockStore = configureStore([]);

const store = mockStore({
  applicationInstances : {},
});

describe('configuration', () => {

  const params = {};
  it('renders the DownloadButton component', () => {
    const result = TestRenderer.create(
      <Provider store={store}>
        <Configuration params={params}/>
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });
});
