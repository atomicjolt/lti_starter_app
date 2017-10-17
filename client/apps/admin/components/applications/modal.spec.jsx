import React from 'react';
import { shallow } from 'enzyme';
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

    result = shallow(<Modal {...props} />);
  });

  it('modal matches snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('saves the application', () => {
    expect(saved).toBeFalsy();
    result.instance().saveApplication();
    expect(saved).toBeTruthy();
  });
});
