import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import { Router } from 'react-router-dom';
import { createMemoryHistory } from 'history';

import Index from './index';

const mockStore = configureStore([]);
const store = mockStore({
  canvasErrors: {
    canvasReAuthorizationRequired: false,
  },
});

describe('index', () => {
  const history = createMemoryHistory();
  let result;
  let props;

  beforeEach(() => {
    props = {};
    result = TestRenderer.create(
      <Provider store={store}>
        <Router history={history}>
          <Index {...props} />
        </Router>
      </Provider>
    );
  });

  it('renders the index', () => {
    expect(result).toBeDefined();
  });
});
