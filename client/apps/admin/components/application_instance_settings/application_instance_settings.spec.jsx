import React from 'react';
import TestRenderer from 'react-test-renderer';

import ApplicationInstanceSettings from './application_instance_settings';

describe('ApplicationInstanceSettings', () => {
  it('renders when props are provided', () => {
    const application = {
      id: 1,
      supported_languages: ['en'],
    };

    const applicationInstance = {
      lti_key: 'key',
    };

    const sites = {

    };

    const tabComponent = null;

    const location = {};

    const result = TestRenderer.create(
      <ApplicationInstanceSettings
        application={application}
        applicationInstance={applicationInstance}
        sites={sites}
        tabComponent={tabComponent}
        location={location}
      />
    );
    expect(result).toMatchSnapshot();
  });

});
