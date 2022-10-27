import React from 'react';
import TestRenderer from 'react-test-renderer';

import { settings_inputs } from './settings_inputs';

describe('settings_inputs', () => {
  it('renders the settings_inputs component', () => {
    const result = TestRenderer.create(
        <settings_inputs />
    );
    expect(result).toMatchSnapshot();
  });
});
