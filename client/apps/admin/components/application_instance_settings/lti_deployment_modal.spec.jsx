import React from 'react';
import TestRenderer from 'react-test-renderer';

import { lti_deployment_modal } from './lti_deployment_modal';

describe('lti_deployment_modal', () => {
  it('renders the lti_deployment_modal component', () => {
    const result = TestRenderer.create(
        <lti_deployment_modal />
    );
    expect(result).toMatchSnapshot();
  });
});
