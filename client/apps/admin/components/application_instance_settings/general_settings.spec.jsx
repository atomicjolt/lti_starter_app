import React from 'react';
import TestRenderer from 'react-test-renderer';

import { general_settings } from './general_settings';

describe('general_settings', () => {
  it('renders the general_settings component', () => {
    const result = TestRenderer.create(
        <general_settings />
    );
    expect(result).toMatchSnapshot();
  });
});
