import React from 'react';
import TestRenderer from 'react-test-renderer';
import SettingsDropDown from './settings_drop_down';

describe('application instance modal', () => {

  let result;

  beforeEach(() => {
    result = TestRenderer.create(<SettingsDropDown />);
  });

  it('renders a list with settings', () => {
    expect(result).toMatchSnapshot();
  });

});
