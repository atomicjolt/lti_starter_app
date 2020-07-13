import React from 'react';
import { shallow } from 'enzyme';
import Header from './header';

describe('application instances header', () => {
  let result;
  let props;
  let newLtiKey;

  beforeEach(() => {
    newLtiKey = false;
    props = {
      application: {
        name: 'test application',
      },
      newLtiInstallKey: () => { newLtiKey = true; },
    };
    result = shallow(<Header {...props} />);
  });

  it('handles the onClick function', () => {
    expect(newLtiKey).toBeFalsy();
    result.find('button').simulate('click');
    expect(newLtiKey).toBeTruthy();
  });
});
