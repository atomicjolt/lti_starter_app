import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import DeleteModal from './delete_modal';

describe('delete modal', () => {
  let result;
  let instance;
  let clicked;
  let props;

  // https://medium.com/@amanverma.dev/mocking-create-portal-to-utilize-react-test-renderer-in-writing-snapshot-uts-c49773c88acd
  beforeAll(() => {
    ReactDOM.createPortal = jest.fn((element, node) => {
      return element
    })
  });

  afterEach(() => {
    ReactDOM.createPortal.mockClear()
  });

  beforeEach(() => {
    clicked = false;
    props = {
      isOpen: true,
      closeModal: () => { clicked = true; },
      deleteRecord: () => { clicked = true; },
    };
    result = TestRenderer.create(<DeleteModal {...props} />);
    instance = result.root;
  });

  it('renders Yes button', () => {
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] === 'Yes');
    expect(!!button).toBe(true);
  });

  it('handles the yes button click event', () => {
    expect(clicked).toBeFalsy();
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] === 'Yes');
    button.props.onClick();
    expect(clicked).toBeTruthy();
  });

  it('renders Cancel button', () => {
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] === 'Cancel');
    expect(!!button).toBe(true);
  });

  it('handles the cancel button click event', () => {
    expect(clicked).toBeFalsy();
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] === 'Cancel');
    button.props.onClick();
    expect(clicked).toBeTruthy();
  });
});
