import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import Search       from './search';

describe('common search', () => {

  let result;
  let search = "";

  const props = {
    search: (value) => { search = value; },
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <Search {...props} />
      </Stub>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('has search input', () => {
    const input = TestUtils.findRenderedDOMComponentWithTag(result, 'input');
    expect(input).toBeDefined();
    expect(input.type).toBe('text');
    expect(input.placeholder).toBe('Search...');
  });

  it('search input changes', () => {
    const input = TestUtils.findRenderedDOMComponentWithTag(result, 'input');
    const newValue = '27';
    input.value = newValue;
    TestUtils.Simulate.change(input);
    expect(input.value).toBe(search);
  });

});
