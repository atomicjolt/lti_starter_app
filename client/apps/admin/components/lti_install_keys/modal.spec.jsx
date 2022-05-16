import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import Modal from './modal';

const mockStore = configureStore([]);
const store = mockStore({});

describe('lti install key modal', () => {

  let result;
  let instance;
  let closed;
  let saved;
  const name = 'the application';

  const closeModal = () => { closed = true; };
  const save = () => { saved = true; };
  const ltiInstallKey = {
    id: 2,
    clientId: 'lti-key',
    iss: 'iss',
    jwksUrl: 'jwksUrl',
    tokenUrl: 'tokenUrl',
    oidcUrl: 'oidcUrl',
    created_at: 'created_at',
  };
  const application = {
    id: 1,
    name
  };

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element, node) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    saved = false;
    closed = false;
    result = TestRenderer.create(
      <Provider store={store}>
        <Modal
          isOpen
          closeModal={closeModal}
          save={save}
          ltiInstallKey={ltiInstallKey}
          application={application}
        />
      </Provider>
    );
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the save function', () => {
    expect(saved).toBeFalsy();
    const buttons = instance.findAllByType('button');
    buttons.find((b) => b.children[0] === 'Save').props.onClick();
    expect(saved).toBeTruthy();
    expect(closed).toBeTruthy();
  });

  it('handles the close function', () => {
    expect(closed).toBeFalsy();
    const buttons = instance.findAllByType('button');
    buttons.find((b) => b.children[0] === 'Cancel').props.onClick();
    expect(closed).toBeTruthy();
  });
});
