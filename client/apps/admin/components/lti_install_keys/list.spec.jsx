import React from 'react';
import TestRenderer from 'react-test-renderer';
import List from './list';

describe('application instances list', () => {
  let result;
  let instance;
  let props;

  beforeEach(() => {
    props = {
      ltiInstallKeys: [
        {
          id: 4,
          application_id: 7,
          clientId: 'lti-key',
          iss: 'iss',
          jwksUrl: 'jwksUrl',
          tokenUrl: 'tokenUrl',
          oidcUrl: 'oidcUrl',
          created_at: 'created_at',
        },
      ],
      application: {},
      disableLtiInstallKey: () => {},
      deleteLtiInstallKey: () => {},
      saveLtiInstallKey: () => {},
      currentSortColumn: '',
      currentSortDirection: '',
      setSort: () => {},
    };
    result = TestRenderer.create(<List {...props} />);
    instance = result.root;
  });

  it('renders table tags', () => {
    const thTags = instance.findByType('th');
    expect(thTags).toBeDefined();
    expect(thTags.length).toEqual(2);
  });
});
