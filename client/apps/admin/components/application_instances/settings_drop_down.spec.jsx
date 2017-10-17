import React from 'react';
import { shallow } from 'enzyme';
import SettingsDropDown from './settings_drop_down';

describe('application instance modal', () => {

  let result;

  beforeEach(() => {
    result = shallow(<SettingsDropDown />);
  });

  it('renders a list with settings', () => {
    expect(result).toMatchSnapshot();
  });

});
