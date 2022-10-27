import React from 'react';
import TestRenderer from 'react-test-renderer';

import { extra_fields } from './extra_fields';

describe('extra_fields', () => {
  it('renders the extra_fields component', () => {
    const result = TestRenderer.create(
        <extra_fields />
    );
    expect(result).toMatchSnapshot();
  });
});
