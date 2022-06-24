import React from 'react';
import TestRenderer from 'react-test-renderer';
import Disabled from './disabled';

describe('the disabled component', () => {
  it('matches the snapshot', () => {
    const result = TestRenderer.create(<Disabled />);
    expect(result).toMatchSnapshot();
  });
});
