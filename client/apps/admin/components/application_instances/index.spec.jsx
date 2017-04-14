import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import Helper       from '../../../../specs_support/helper';
import { Index }    from './index';

describe('application instances index', () => {

  let result;
  let applicationInstances = false;

  const props = {
    applicationInstances: [],
    getApplicationInstances: () => { applicationInstances = true; },
    createApplicationInstance: () => {},
    saveApplicationInstance: () => {},
    deleteApplicationInstance: () => {},
    sites: {},
    applications: {},
    params: {
      applicationId: 'id',
    },
    settings: {},
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Index {...props} />
      </Provider>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('Loads application instances', () => {
    expect(applicationInstances).toBe(true);
  });

});
