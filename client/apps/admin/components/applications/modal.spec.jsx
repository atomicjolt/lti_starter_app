import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils, { act } from 'react-dom/test-utils';
import Modal from './modal';

describe('applications modal', () => {
  let result;
  let saved;

  const application = {
    name: 'SPEC_NAME',
    description: 'SPEC_STRING'
  };
  const isOpen = true;
  const closeModal = () => {};
  const save = () => { saved = true; };

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element, node) => element);
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear();
  });

  beforeEach(() => {
    saved = false;

    result = TestRenderer.create(
      <Modal
        application={application}
        isOpen={isOpen}
        closeModal={closeModal}
        save={save}
      />);
  });

  it('modal matches snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('saves the application', () => {
    expect(saved).toBeFalsy();

    const container = document.createElement('div');
    document.body.appendChild(container);
    act(() => {
      ReactDOM.render(
        <Modal
          application={application}
          isOpen={isOpen}
          closeModal={closeModal}
          save={save}
        />,
        container
      );
    });
    const buttons = document.getElementsByTagName('button');
    expect(buttons.length).toEqual(2);
    const button = buttons[0];
    ReactTestUtils.Simulate.click(button);

    expect(saved).toBeTruthy();
  });
});
