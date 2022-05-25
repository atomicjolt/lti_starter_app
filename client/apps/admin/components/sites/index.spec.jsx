import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import Index from './index';

jest.mock('../../libs/assets');

const sitesData = {
  1: {
    id: 1,
    url: 'bfcoder.com'
  },

  2: {
    id: 2,
    url: 'atomicjolt.com'
  }
};

const sites = sitesData;

const mockStore = configureStore([]);
const store = mockStore({
  sites,
  settings: {
    sign_out_url: 'https://www.example.com',
  },
});

describe('sites index', () => {
  let result;

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <Index />
      </Provider>);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
