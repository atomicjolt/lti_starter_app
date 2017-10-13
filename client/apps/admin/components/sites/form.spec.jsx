import React from 'react';
import { shallow } from 'enzyme';
import Form from './form';

describe('site form', () => {
  let result;
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
    result = shallow(<Form {...props} />);
  });

  it('renders the form', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the Domain onclick event', () => {
    expect(modalClosed).toBeFalsy();
    result.find('.c-btn--yellow').simulate('click');
    expect(modalClosed).toBeTruthy();
  });

  describe('close modal', () => {
    it('closes', () => {
      expect(modalClosed).toBeFalsy();
      const button = result.find('.c-btn--gray--large');
      button.simulate('click');
      expect(modalClosed).toBeTruthy();
    });
  });
});
