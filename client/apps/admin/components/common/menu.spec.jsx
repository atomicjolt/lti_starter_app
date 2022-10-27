import React from 'react';
import TestRenderer from 'react-test-renderer';

import { menu } from './menu';

describe('menu', () => {
  it('renders the menu component', () => {
    const result = TestRenderer.create(
        <menu />
    );
    expect(result).toMatchSnapshot();
  });
});
