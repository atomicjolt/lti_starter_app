import React from 'react';
import TestRenderer from 'react-test-renderer';

import { XmlConfig } from './xml_config';

describe('XmlConfig', () => {
  it('renders the XmlConfig component', () => {

    const applicationInstance = {
      id: 1,
    };

    const applicationInstances = [
      applicationInstance,
    ];

    const params = {
      applicationId: "1",
      applicationInstanceId: "1",
    };

    const result = TestRenderer.create(
        <XmlConfig applicationInstances={applicationInstances} params={params}/>
    );
    expect(result).toMatchSnapshot();
  });
});
