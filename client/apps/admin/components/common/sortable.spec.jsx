import React from 'react';
import TestRenderer from 'react-test-renderer';

import Sortable from './sortable';

describe('Sortable', () => {
  it('renders the Sortable component', () => {
    const result = TestRenderer.create(
        <Sortable />
    );
    expect(result).toMatchSnapshot();
  });
});
