import React from 'react';
import TestRenderer from 'react-test-renderer';

import { nav_column } from './nav_column';

describe('nav_column', () => {
  it('renders the nav_column component', () => {
    const result = TestRenderer.create(
        <nav_column />
    );
    expect(result).toMatchSnapshot();
  });
});
