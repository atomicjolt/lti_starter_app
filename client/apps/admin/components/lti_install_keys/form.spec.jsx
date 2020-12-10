import React from 'react';
import { shallow } from 'enzyme';
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
    result = shallow(<Form {...props} />);
  });

  it('handles the close modal event', () => {
    expect(modalClosed).toBeFalsy();
    result.find('.c-btn--gray--large').simulate('click');
    expect(modalClosed).toBeTruthy();
  });

  it('handles the save event', () => {
    expect(saved).toBeFalsy();
    result.find('.c-btn--yellow').simulate('click');
    expect(saved).toBeTruthy();
  });
});
