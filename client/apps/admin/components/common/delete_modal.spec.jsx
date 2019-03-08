import React from 'react';
import { mount } from 'enzyme';
import DeleteModal from './delete_modal';

describe('delete modal', () => {
  let result;
  let clicked;
  let props;

  beforeEach(() => {
    clicked = false;
    props = {
      isOpen: true,
      closeModal: () => { clicked = true; },
      deleteRecord: () => { clicked = true; },
    };
    result = mount(<DeleteModal {...props} />);
  });

  it('renders Yes button', () => {
    const button = result.find('.c-btn--red');
    expect(button.props().children).toContain('Yes');
  });

  it('handles the yes button click event', () => {
    expect(clicked).toBeFalsy();
    result.find('.c-btn--red').simulate('click');
    expect(clicked).toBeTruthy();
  });

  it('renders Cancel button', () => {
    const button = result.find('.c-btn--gray--large');
    expect(button.props().children).toBe('Cancel');
  });

  it('handles the yes button click event', () => {
    expect(clicked).toBeFalsy();
    result.find('.c-btn--gray--large').simulate('click');
    expect(clicked).toBeTruthy();
  });
});
