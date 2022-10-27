import React from 'react';
import TestRenderer from 'react-test-renderer';

import { lti_install_selector } from './lti_install_selector';

describe('lti_install_selector', () => {
  it('renders the lti_install_selector component', () => {
    const result = TestRenderer.create(
        <lti_install_selector />
    );
    expect(result).toMatchSnapshot();
  });
});
