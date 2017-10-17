import React from 'react';
import { shallow } from 'enzyme';
import Enabled from './enabled';

describe('the enabled component', () => {
  it('matches the snapshot', () => {
    const result = shallow(<Enabled />);
    expect(result).toMatchSnapshot();
  });
});
