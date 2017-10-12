import React           from 'react';
import { shallow } from 'enzyme';
import Form from './form';

describe('application instance form', () => {
  let result;
  let props;
  let modalClosed = false;
  let saved = false;

  beforeEach(() => {
    props = {
      onChange: () => {},
      closeModal: () => { modalClosed = true; },
      save: () => { saved = true; },
      newSite: () => {},
      site_id: 'foo',
      sites: {},
      config: '{ "foo": "bar" }',
    };
    result = shallow(<Form {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
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
