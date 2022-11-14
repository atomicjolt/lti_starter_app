import React from 'react';
import TestRenderer from 'react-test-renderer';

import { GeneralSettings } from './general_settings';

describe('GeneralSettings', () => {
  it('renders the GeneralSettings component', () => {

    const languagesSupported = [];
    const params = {
      applicationId: '7',
      applicationInstanceId: '12',
    }
    const loading = false;
    const loaded = true;
    const sites = {
      3: {
        id: 3,
        url: 'https://www.example.com',
      }
    };
    const applicationInstances = [{
      id: 12,
      application_id: 7,
      site: {
        id: 3,
      },
    }];

    const result = TestRenderer.create(
      <GeneralSettings 
        languagesSupported={languagesSupported}
        params={params}
        loading={loading}
        loaded={loaded}
        sites={sites}
        applicationInstances
      />
    );
    expect(result).toMatchSnapshot();
  });
});
