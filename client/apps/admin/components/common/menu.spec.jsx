import React from 'react';
import TestRenderer from 'react-test-renderer';

import Menu from './menu';

describe('Menu', () => {
  it('renders the Menu component', () => {
    const result = TestRenderer.create(
        <Menu />
    );
    expect(result).toMatchSnapshot();
  });
});
