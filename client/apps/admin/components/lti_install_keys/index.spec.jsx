import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Index } from './index';

jest.mock('../../libs/assets');
describe('application instances index', () => {

  let result;
  let props;
  let ltiInstallKeys = false;

  beforeEach(() => {
    props = {
      ltiInstallKeys: [{ ltiInstallKeys: {} }],
      getLtiInstallKeys: () => { ltiInstallKeys = true; },
      createLtiInstallKey: () => {},
      saveLtiInstallKey: () => {},
      deleteLtiInstallKey: () => {},
      applications: {},
      params: {
        applicationId: 'id',
      },
      totalPages: 10,
    };
    result = TestRenderer.create(<Index {...props} />);
  });

  it('loads the lti install keys', () => {
    expect(ltiInstallKeys).toBeTruthy();
  });

  it('renders table tags', () => {
    expect(result).toBeDefined();
  });
});
