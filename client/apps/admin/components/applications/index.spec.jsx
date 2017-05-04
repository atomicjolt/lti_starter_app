import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import Helper from '../../../../specs_support/helper';
import { Index } from './index';
import sites from '../../reducers/sites';

describe('applications index', () => {

  let result;
  let props;
  const sitesData = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  beforeEach(() => {
    props = {
      saveApplication: () => {},
      applications: {
        Spiderman: {
          Power1: 'Wall Crawling',
          Power2: 'Spidey Sense'
        }
      }
    };

    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore({}, { sites: sitesData }, { sites })}>
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
