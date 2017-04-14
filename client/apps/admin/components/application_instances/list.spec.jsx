import React     from 'react';
import TestUtils from 'react-dom/test-utils';
import Stub      from '../../../../specs_support/stub';
import List      from './list';

describe('application instances list', () => {

  let result;
  const props = {
    applicationInstances: [],
    settings: {},
    deleteApplicationInstance: () => {},
    saveApplicationInstance: () => {},
    sites: { 1: { id: 1, url: 'http://www.example.com' } },
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <List {...props} />
      </Stub>
    );
  });

  it('renders the list with header values', () => {
    const thead = TestUtils.findRenderedDOMComponentWithTag(result, 'thead');
    expect(thead.textContent).toContain('INSTANCE');
    expect(thead.textContent).toContain('LTI KEY');
    expect(thead.textContent).toContain('DOMAIN');
  });


});
