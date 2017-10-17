import React from 'react';
import { shallow } from 'enzyme';
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
    result = shallow(<Search {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('has search input', () => {
    const input = result.find('input');
    expect(input).toBeDefined();
    expect(input.props().type).toBe('text');
    expect(input.props().placeholder).toBe('Search...');
  });

  it('search input changes', () => {
    expect(search).toBeFalsy();
    result.find('input').simulate('change', { target: { value: 'new value' } });
    expect(search).toBeTruthy();
  });
});
