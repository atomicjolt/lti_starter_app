import React from 'react';
import TestRenderer from 'react-test-renderer';

import NavColumn from './nav_column';

describe('NavColumn', () => {
  it('renders the NavColumn component', () => {
    const application = {
      id: 123,
    };

    const applicationInstance = {
      id: 456,
    };

    const location = {
      pathname: "",
    };

    const result = TestRenderer.create(
        <NavColumn application={application} applicationInstance={applicationInstance} location={location}/>
    );
    expect(result).toMatchSnapshot();
  });
});
