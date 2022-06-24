import React from 'react';
import TestRenderer from 'react-test-renderer';
import Form from './form';

describe('site form', () => {
  let result;
  let instance;
  let props;
  let modalClosed;

  beforeEach(() => {
    modalClosed = false;
    props = {
      setupSite: () => { modalClosed = true; },
      closeModal: () => { modalClosed = true; },
      onChange: () => {},
      isUpdate: false,
    };
    result = TestRenderer.create(<Form {...props} />);
    instance = result.root;
  });

  it('renders the form', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the Domain onclick event', () => {
    expect(modalClosed).toBeFalsy();
    const buttons = instance.findAllByType('button');
    const button = buttons.find(b => b.children[0] !== 'Cancel');
    button.props.onClick();
    expect(modalClosed).toBeTruthy();
  });

  describe('close modal', () => {
    it('closes', () => {
      expect(modalClosed).toBeFalsy();
      const buttons = instance.findAllByType('button');
      const button = buttons.find(b => b.children[0] === 'Cancel');
      button.props.onClick();
      expect(modalClosed).toBeTruthy();
    });
  });
});
