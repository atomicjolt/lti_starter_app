import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import Index from './index';

jest.mock('../../libs/assets');
const applications = {
  Spiderman: {
    Power1: 'Wall Crawling',
    Power2: 'Spidey Sense'
  }
};
const settings =  {
  sign_out_url: 'https://www.example.com',
};
const mockStore = configureStore([]);
const store = mockStore({ applications, settings });
describe('applications index', () => {

  let result;

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <Index />
      </Provider>
    );
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
