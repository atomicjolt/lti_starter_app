import React from 'react';
import TestRenderer from 'react-test-renderer';
import Enabled from './enabled';

describe('the enabled component', () => {
  it('matches the snapshot', () => {
    const result = TestRenderer.create(<Enabled />);
    expect(result).toMatchSnapshot();
  });
});
