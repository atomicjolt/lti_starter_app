import React from 'react';
import TestRenderer from 'react-test-renderer';

import { lti_advantage_settings } from './lti_advantage_settings';

describe('lti_advantage_settings', () => {
  it('renders the lti_advantage_settings component', () => {
    const result = TestRenderer.create(
        <lti_advantage_settings />
    );
    expect(result).toMatchSnapshot();
  });
});
