import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import Home from './home';

const mockStore = configureStore([]);
const store = mockStore({
  canvasRequest: () => {},
  settings: {
    canvas_auth_required: false,
  },
  canvasErrors: {
    canvasReAuthorizationRequired: false,
  },
});

describe('home', () => {
  it('renders the home component', () => {
    const result = TestRenderer.create(
      <Provider store={store}>
        <Home />
      </Provider>
    );
    expect(result).toMatchSnapshot();
  });

});
