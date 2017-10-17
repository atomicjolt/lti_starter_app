import React from 'react';
import { shallow } from 'enzyme';
import Disabled from './disabled';

describe('the disabled component', () => {
  it('matches the snapshot', () => {
    const result = shallow(<Disabled />);
    expect(result).toMatchSnapshot();
  });
});
