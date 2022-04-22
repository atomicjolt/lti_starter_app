import React from 'react';
import TestRenderer, { act } from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import Index from './index';

const mockStore = configureStore([]);
const store = mockStore({});

describe('layout index', () => {
  let result;
  const location = {
    pathname: '/'
  };
  const text = 'hello';

  beforeEach(() => {
    act(() => {
      result = TestRenderer.create(
        <Provider store={store}>
          <Index location={location}>
            <h1>{text}</h1>
          </Index>
        </Provider>
      );
    });
  });

  it('renders the index', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('Loads sites and applications', () => {
    // Test that the store dispatched an action to get sites and applications
    const actions = store.getActions();
    expect(!!actions.find((a) => a.type === 'GET_APPLICATIONS')).toEqual(true);
    expect(!!actions.find((a) => a.type === 'GET_SITES')).toEqual(true);
  });
});
