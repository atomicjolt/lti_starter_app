import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { Provider } from 'react-redux';
import Helper from '../../../../specs_support/helper';
import { Index } from './index';
import sites from '../../reducers/sites';

jest.mock('../../libs/assets');
describe('application instances index', () => {

  let result;
  let applicationInstances = false;
  const sitesData = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  const props = {
    applicationInstances: [],
    getApplicationInstances: () => { applicationInstances = true; },
    createApplicationInstance: () => {},
    saveApplicationInstance: () => {},
    deleteApplicationInstance: () => {},
    sites: sitesData,
    applications: {},
    params: {
      applicationId: 'id',
    },
    settings: {
      canvas_callback_url: 'https://www.example.com'
    },
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore({}, { sites: sitesData }, { sites })}>
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
