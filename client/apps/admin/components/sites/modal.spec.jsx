import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import SiteModal from './modal';

const settings = {
  lti_key: 'abc123',
  canvas_callback_url: 'http://example.com',
};

const mockStore = configureStore([]);
const store = mockStore({ settings });

describe('site modal', () => {
  let result;

  const url = 'bfcoder.com';
  const isOpen = true;
  const closeModal = () => {};
  const site = {
    id: 1,
    url,
  };

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element, node) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    result = TestRenderer.create(
      <Provider store={store}>
        <SiteModal
          isOpen={isOpen}
          closeModal={closeModal}
          site={site}
        />
      </Provider>
    );
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
