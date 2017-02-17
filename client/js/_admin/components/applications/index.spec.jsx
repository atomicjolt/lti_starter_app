import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import Helper       from '../../../../specs_support/helper';
import { Index }    from './index';

describe('applications index', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      saveApplication: () => {},
      applications: {
        Spiderman: {
          Power1: "Wall Crawling",
          Power2: "Spidey Sense"
        }
      }
    };

    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Index {...props} />
      </Provider>
    );
  });

  it('render the application rows', () => {
    const element = TestUtils.findRenderedDOMComponentWithClass(result, 'o-contain o-contain--full');
    expect(element).toBeDefined();
  });

  it('render application', () => {
    const element = TestUtils.findRenderedDOMComponentWithTag(result, 'tbody');
    expect(element.childNodes.length).toBeGreaterThan(0);
  });

});
