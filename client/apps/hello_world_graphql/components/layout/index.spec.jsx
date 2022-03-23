import React from 'react';
import TestRenderer from 'react-test-renderer';
import { MockedProvider } from '@apollo/client/testing';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import { Router } from 'react-router-dom'
import { createMemoryHistory } from 'history';

import Index from './index';
import { GET_WELCOME } from '../home';

jest.mock('../../libs/assets.js');

const mockStore = configureStore([]);
const store = mockStore({
  canvasErrors: {
    canvasReAuthorizationRequired: false,
  },
});

const mocks = [
  {
    request: {
      query: GET_WELCOME,
      variables: { name: 'World' },
    },
    result: {
      data: {
        welcomeMessage: 'Hello World!',
      },
    },
  },
];

describe('index', () => {
  const history = createMemoryHistory();
  let result;
  let props;

  beforeEach(() => {
    props = {};
    result = TestRenderer.create(
      <Provider store={store}>
        <MockedProvider mocks={mocks} addTypename={false}>
        <Router history={history}>
          <Index {...props} />
        </Router>
        </MockedProvider>
      </Provider>
    );
  });

  it('renders the index', () => {
    expect(result).toBeDefined();
  });
});
