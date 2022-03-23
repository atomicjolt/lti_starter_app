import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import Modal from './modal';

const mockStore = configureStore([]);
const store = mockStore({});

describe('lti install key modal', () => {

  let result;
  let props;
  let closed;
  let saved;
  const name = 'the application';

  beforeEach(() => {
    saved = false;
    closed = false;
    props = {
      isOpen: true,
      closeModal: () => { closed = true; },
      save: () => { saved = true; },
      ltiInstallKey: {
        id: 2,
        clientId: 'lti-key',
        iss: 'iss',
        jwksUrl: 'jwksUrl',
        tokenUrl: 'tokenUrl',
        oidcUrl: 'oidcUrl',
        created_at: 'created_at',
      },
      application: {
        id: 1,
        name
      }
    };
    result = TestRenderer.create(
      <Provider store={store}>
        <Modal {...props} />
      </Provider>
    );
  });

  it('handles the save function', () => {
    expect(saved).toBeFalsy();
    result.root.save();
    expect(saved).toBeTruthy();
  });

  it('handles the close function', () => {
    expect(closed).toBeFalsy();
    result.root.closeModal();
    expect(closed).toBeTruthy();
  });
});
