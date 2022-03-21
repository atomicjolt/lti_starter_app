import React from 'react';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import TestRenderer, { act } from 'react-test-renderer';
import { MockedProvider } from '@apollo/client/testing';
import waitForExpect from 'wait-for-expect';
import Home, { GET_WELCOME } from './home';

jest.mock('../libs/assets.js');

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

const mockStore = configureStore([]);
const store = mockStore({
  canvasErrors: {
    canvasReAuthorizationRequired: false,
  },
});

describe('home', () => {
  it('should render loading state initially', () => {
    let testRenderer;
    act(() => {
      testRenderer = TestRenderer.create(
        <Provider store={store}>
          <MockedProvider mocks={mocks} addTypename={false}>
            <Home />
          </MockedProvider>
        </Provider>,
      );
    });

    const tree = testRenderer.toJSON();
    expect(JSON.stringify(tree).indexOf('Hello World!') === -1).toBe(true);
  });

  it('renders the home component', async() => {
    let testRenderer;
    await act(async() => {
      testRenderer = TestRenderer.create(
        <Provider store={store}>
          <MockedProvider mocks={mocks} addTypename={false}>
            <Home />
          </MockedProvider>
        </Provider>,
      );
    });

    await waitForExpect(() => {
      expect(JSON.stringify(testRenderer.toJSON()).indexOf('Hello World!') >= 0).toBe(true);
    });
  });
});
