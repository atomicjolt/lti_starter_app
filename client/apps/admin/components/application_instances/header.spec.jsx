import React from 'react';
import { shallow } from 'enzyme';
import Header from './header';

describe('application instances header', () => {
  let result;
  let props;
  let newInstance;

  beforeEach(() => {
    newInstance = false;
    props = {
      application: {
        name: 'test application',
      },
      newApplicationInstance: () => { newInstance = true; },
    };
    result = shallow(<Header {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onClick function', () => {
    expect(newInstance).toBeFalsy();
    result.find('button').simulate('click');
    expect(newInstance).toBeTruthy();
  });
});
