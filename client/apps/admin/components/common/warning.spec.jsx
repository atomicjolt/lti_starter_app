import React from 'react';
import TestRenderer from 'react-test-renderer';
import Warning from './warning';

describe('warning', () => {
  let result;
  let instance;
  let props;

  beforeEach(() => {
    props = {
      text: 'bfcoder was here',
    };
    result = TestRenderer.create(<Warning {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders the warning', () => {
    const warning = instance.findByType('div');
    expect(warning.props.children[1]).toContain(props.text);
  });
});
