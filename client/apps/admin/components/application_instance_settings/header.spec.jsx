import React from 'react';
import TestRenderer from 'react-test-renderer';

import { Header } from './header';

describe('Header', () => {
  const applicationInstance = {
    site: {},
  };
  const application = {};

  it('renders the Header component', () => {
    const result = TestRenderer.create(
        <Header applicationInstance={applicationInstance} application={application}/>
    );
    expect(result).toMatchSnapshot();
  });
});
