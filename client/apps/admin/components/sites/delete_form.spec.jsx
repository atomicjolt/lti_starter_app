import React from 'react';
import { shallow } from 'enzyme';
import DeleteForm from './delete_form';

describe('sites delete form', () => {
  let result;
  let clicked;
  let props;

  beforeEach(() => {
    clicked = false;
    props = {
      deleteSite: () => { clicked = true; },
      closeModal: () => { clicked = true; },
    };
    result = shallow(<DeleteForm {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
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
