import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import Helper       from '../../../../specs_support/helper';
import { Index }    from './index';

describe('index', () => {
  let result;
  let props;

  const text = 'hello';
  const children = <h1>{text}</h1>;

  beforeEach(() => {
    props = {
      children,
      getApplications: () => {},
    };

    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Index {...props} />
      </Provider>);
  });

  it('renders the index', () => {
    expect(result).toBeDefined();
  });

  it('renders the child component', () => {
    const child = TestUtils.findRenderedDOMComponentWithTag(result, 'h1');
    expect(child.textContent).toBe(text);
  });

});
