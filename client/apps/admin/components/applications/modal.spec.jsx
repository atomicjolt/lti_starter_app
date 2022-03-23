import React from 'react';
import TestRenderer from 'react-test-renderer';
import Modal from './modal';

describe('applications modal', () => {
  let result;
  let props;
  let saved;

  beforeEach(() => {
    saved = false;
    props = {
      application: {
        name        : 'SPEC_NAME',
        description : 'SPEC_STRING'
      },
      isOpen: true,
      closeModal: () => {},
      save: () => { saved = true; },
    };

    result = TestRenderer.create(<Modal {...props} />);
  });

  it('modal matches snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('saves the application', () => {
    expect(saved).toBeFalsy();
    result.root.saveApplication();
    expect(saved).toBeTruthy();
  });
});
