import React from 'react';
import { shallow } from 'enzyme';
import { Index } from './index';
import sites from '../../reducers/sites';

jest.mock('../../libs/assets');
describe('application instances index', () => {

  let result;
  let props;
  let applicationInstances = false;
  const sitesData = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  beforeEach(() => {
    props = {
      applicationInstances: [{ applicationInstances: {} }],
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
      canvasOauthURL: 'https://www.example.com',
      disableApplicationInstance: () => {},
    };
    result = shallow(<Index {...props} />);
  });

  it('loads the assessments', () => {
    expect(applicationInstances).toBeTruthy();
  });
});
