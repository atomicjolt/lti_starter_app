import React from 'react';
import TestRenderer from 'react-test-renderer';

import { xml_config } from './xml_config';

describe('xml_config', () => {
  it('renders the xml_config component', () => {
    const result = TestRenderer.create(
        <xml_config />
    );
    expect(result).toMatchSnapshot();
  });
});
