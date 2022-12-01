import React from 'react';
import { Provider } from 'react-redux';
import TestRenderer from 'react-test-renderer';
import Heading from './heading';
import configureStore from 'redux-mock-store';

const mockStore = configureStore([]);

const store = mockStore({
  settings: {
    sign_out_url: 'https://www.example.com'
  },
  sites : { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } },
});

describe('common heading', () => {
  let result;
  let props;
  const sites = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  beforeEach(() => {
    props = {
      backTo: '/',
      userName: 'username',
      signOutUrl: 'https://www.example.com',
      sites,
    };
    result = TestRenderer.create(
      <Provider store={store}>
        <Heading {...props} />
      </Provider>
    );
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
