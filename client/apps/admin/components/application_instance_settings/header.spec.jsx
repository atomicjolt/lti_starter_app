import React from 'react';
import TestRenderer from 'react-test-renderer';

import { header } from './header';

describe('header', () => {
  it('renders the header component', () => {
    const result = TestRenderer.create(
        <header />
    );
    expect(result).toMatchSnapshot();
  });
});
