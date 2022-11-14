import React from 'react';
import TestRenderer from 'react-test-renderer';

import SettingsInputs from './settings_inputs';

describe('SettingsInputs', () => {
  it('renders the SettingsInputs component', () => {
    const result = TestRenderer.create(
        <SettingsInputs />
    );
    expect(result).toMatchSnapshot();
  });
});
