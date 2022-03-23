import React from 'react';
import TestRenderer from 'react-test-renderer';
import Form from './form';

describe('lti install key form', () => {
  let result;
  let props;
  let modalClosed = false;
  let saved;

  beforeEach(() => {
    saved = false;
    props = {
      onChange: () => {},
      closeModal: () => { modalClosed = true; },
      save: () => { saved = true; },
    };
    result = TestRenderer.create(<Form {...props} />);
  });

  it('handles the close modal event', () => {
    expect(modalClosed).toBeFalsy();
    instance.findByType('.c-btn--gray--large').simulate('click');
    expect(modalClosed).toBeTruthy();
  });

  it('handles the save event', () => {
    expect(saved).toBeFalsy();
    instance.findByType('.c-btn--yellow').simulate('click');
    expect(saved).toBeTruthy();
  });
});
