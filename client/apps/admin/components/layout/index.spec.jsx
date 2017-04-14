import React        from 'react';
import TestUtils    from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import Helper       from '../../../../specs_support/helper';
import { Index }    from './index';

describe('layout index', () => {
  let result;

  let getSites = false;
  let getApplications = false;

  let props;

  const text = 'hello';
  const children = <h1>{text}</h1>;

  beforeEach(() => {
    props = {
      children,
      getApplications: () => { getApplications = true; },
      getSites: () => { getSites = true; },
      location: {
        pathname: '/'
      },
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

  it('Loads sites', () => {
    expect(getSites).toBe(true);
  });

  it('Loads applications', () => {
    expect(getApplications).toBe(true);
  });

});
