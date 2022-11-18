import React from 'react';
import TestRenderer from 'react-test-renderer';

import { Configuration } from './configuration';

describe('configuration', () => {
  it('renders the DownloadButton component', () => {
    const result = TestRenderer.create(
        <Configuration />
    );
    expect(result).toMatchSnapshot();
  });
});
