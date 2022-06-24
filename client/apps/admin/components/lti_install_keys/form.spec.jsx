import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils, { act } from 'react-dom/test-utils';
import Form from './form';

describe('lti install key form', () => {
  let result;
  let modalClosed = false;
  let saved;

  const onChange = () => {};
  const closeModal = () => { modalClosed = true; };
  const save = () => { saved = true; };

  beforeEach(() => {
    saved = false;
    result = TestRenderer.create(
      <Form
        onChange={onChange}
        closeModal={closeModal}
        save={save}
      />);
  });

  const container = document.createElement('div');
  document.body.appendChild(container);
  act(() => {
    ReactDOM.render(
      <Form
        onChange={onChange}
        closeModal={closeModal}
        save={save}
      />,
      container
    );
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the close modal event', () => {
    expect(modalClosed).toBeFalsy();
    const buttons = document.getElementsByTagName('button');
    expect(buttons.length).toEqual(2);
    const button = buttons[1];
    ReactTestUtils.Simulate.click(button);

    expect(modalClosed).toBeTruthy();
  });

  it('handles the save event', () => {
    expect(saved).toBeFalsy();
    const buttons = document.getElementsByTagName('button');
    expect(buttons.length).toEqual(2);
    const button = buttons[0];
    ReactTestUtils.Simulate.click(button);

    expect(saved).toBeTruthy();
  });
});
