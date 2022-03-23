import React from 'react';
import TestRenderer from 'react-test-renderer';
import Search from './search';

describe('common search', () => {
  let result;
  let search;
  let props;

  beforeEach(() => {
    search = false;
    props = {
      search: () => { search = true; },
    };
    result = TestRenderer.create(<Search {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('has search input', () => {
    const input = instance.findByType('input');
    expect(input).toBeDefined();
    expect(input.props().type).toBe('text');
    expect(input.props().placeholder).toBe('Search...');
  });

  it('search input changes', () => {
    expect(search).toBeFalsy();
    instance.findByType('input').simulate('change', { target: { value: 'new value' } });
    expect(search).toBeTruthy();
  });
});
