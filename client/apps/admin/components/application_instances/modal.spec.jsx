import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';

import Modal from './modal';

const mockStore = configureStore([]);
const store = mockStore({
  settings: {
    canvas_callback_url: 'https://www.example.com',
  },
});

describe('application instance modal', () => {
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
      sites: {},
      save: () => { saved = true; },
      applicationInstance: {
        id: 2,
        config: 'config string',
        site: {
          id: 3,
        },
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

  it('match the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the changing of the siteModalOpen state open', () => {
    expect(result.root.state.siteModalOpen).toBeFalsy();
    result.root.newSite();
    expect(result.root.state.siteModalOpen).toBeTruthy();
  });

  it('handles the changing of the siteModalOpen state to close', () => {
    expect(closed).toBeFalsy();
    expect(result.root.state.siteModalOpen).toBeFalsy();
    result.root.newSite();
    expect(result.root.state.siteModalOpen).toBeTruthy();
    result.root.closeModal();
    expect(closed).toBeTruthy();
    expect(result.root.state.siteModalOpen).toBeFalsy();
  });

  it('handles the save function', () => {
    expect(saved).toBeFalsy();
    expect(result.root.state.siteModalOpen).toBeFalsy();
    result.root.newSite();
    expect(result.root.state.siteModalOpen).toBeTruthy();
    result.root.save();
    expect(saved).toBeTruthy();
  });
});
