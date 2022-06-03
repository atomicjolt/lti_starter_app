import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import selectEvent from 'react-select-event';
import { fireEvent, render } from '@testing-library/react';
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
  let closed;
  let saved;
  const name = 'the application';

  const isOpen = true;
  const closeModal = () => { closed = true; };
  const sites = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };
  const save = () => { saved = true; };
  const applicationInstance = {
    id: 2,
    config: 'config string',
    site: {
      id: 3,
    },
  };
  const application = {
    id: 1,
    name
  };

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element) => element);
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
          isOpen={isOpen}
          closeModal={closeModal}
          sites={sites}
          save={save}
          applicationInstance={applicationInstance}
          application={application}
        />
      </Provider>
    );
  });

  it('match the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the changing of the siteModalOpen state open', async() => {
    const { getAllByRole, getByText } = render(
      <Provider store={store}>
        <Modal
          isOpen={isOpen}
          closeModal={closeModal}
          sites={sites}
          save={save}
          applicationInstance={applicationInstance}
          application={application}
        />
      </Provider>
    );
    const node = await getAllByRole('combobox')[0];
    expect(node).toBeDefined();
    await selectEvent.select(node, 'Add New');
    const test = await getByText('New Domain');
    expect(test).toBeDefined();
  });

  it('handles the changing of the siteModalOpen state to close', async() => {
    const { getAllByRole } = render(
      <Provider store={store}>
        <Modal
          isOpen={isOpen}
          closeModal={closeModal}
          sites={sites}
          save={save}
          applicationInstance={applicationInstance}
          application={application}
        />
      </Provider>
    );

    const node = getAllByRole('combobox')[0];
    expect(node).toBeDefined();
    await selectEvent.select(node, 'Add New');
    const cancelButton = getAllByRole('button')[1];
    fireEvent.click(cancelButton);
    expect(closed).toBeTruthy();
  });

  it('handles the save function', async() => {
    const { getAllByRole } = render(
      <Provider store={store}>
        <Modal
          isOpen={isOpen}
          closeModal={closeModal}
          sites={sites}
          save={save}
          applicationInstance={applicationInstance}
          application={application}
        />
      </Provider>
    );
    const node = getAllByRole('combobox')[0];
    expect(node).toBeDefined();
    await selectEvent.select(node, 'Add New');
    const saveButton = getAllByRole('button')[0];
    fireEvent.click(saveButton);
    expect(saved).toBeTruthy();
  });
});
