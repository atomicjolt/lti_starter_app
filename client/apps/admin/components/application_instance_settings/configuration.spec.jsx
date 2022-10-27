import React from 'react';
import TestRenderer from 'react-test-renderer';

import { configuration } from './configuration';

describe('configuration', () => {
  it('renders the DownloadButton component', () => {
    const result = TestRenderer.create(
        <configuration />
    );
    expect(result).toMatchSnapshot();
  });
});
