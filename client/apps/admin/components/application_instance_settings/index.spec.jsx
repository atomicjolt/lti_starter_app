import React from 'react';
import TestRenderer from 'react-test-renderer';

import { index } from './index';

describe('index', () => {
  it('renders the index component', () => {
    const result = TestRenderer.create(
        <index />
    );
    expect(result).toMatchSnapshot();
  });
});
