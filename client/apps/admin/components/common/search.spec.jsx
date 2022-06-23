import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils, { act } from 'react-dom/test-utils';
import Search from './search';

describe('common search', () => {
  let result;
  let isSearch;
  let instance;

  const search = () => { isSearch = true; };

  beforeEach(() => {
    isSearch = false;
    result = TestRenderer.create(
      <Search
        search={search}
      />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('has search input', () => {
    const input = instance.findByType('input');
    expect(input).toBeDefined();
    expect(input.props.type).toBe('text');
    expect(input.props.placeholder).toBe('Search...');
  });

  it('search input changes', () => {
    expect(isSearch).toBeFalsy();
    const container = document.createElement('div');
    document.body.appendChild(container);
    act(() => {
      ReactDOM.render(
        <Search
          search={search}
        />,
        container
      );
    });
    const inputs = document.getElementsByTagName('input');
    expect(inputs.length).toEqual(1);
    const input = inputs[0];
    const event = { target: { value: 'test onChange' } };
    ReactTestUtils.Simulate.change(input, event);
    expect(isSearch).toBeTruthy();
    // expect(input.onChange).toHaveBeenCalledTimes(1);
  });
});
