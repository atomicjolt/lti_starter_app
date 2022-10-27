import React from 'react';
import TestRenderer from 'react-test-renderer';

import { sortable } from './sortable';

describe('sortable', () => {
  it('renders the sortable component', () => {
    const result = TestRenderer.create(
        <sortable />
    );
    expect(result).toMatchSnapshot();
  });
});
