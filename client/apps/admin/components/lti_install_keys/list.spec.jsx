import React from 'react';
import TestRenderer from 'react-test-renderer';
import List from './list';

describe('application instances list', () => {
  let result;
  let instance;

  const ltiInstallKeys = [
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
  ];
  const application = {};
  const disableLtiInstallKey = () => {};
  const deleteLtiInstallKey = () => {};
  const saveLtiInstallKey = () => {};
  const currentSortColumn = '';
  const currentSortDirection = '';
  const setSort = () => {};

  beforeEach(() => {
    result = TestRenderer.create(<List
      ltiInstallKeys={ltiInstallKeys}
      application={application}
      disableLtiInstallKey={disableLtiInstallKey}
      deleteLtiInstallKey={deleteLtiInstallKey}
      saveLtiInstallKey={saveLtiInstallKey}
      currentSortColumn={currentSortColumn}
      currentSortDirection={currentSortDirection}
      setSort={setSort}
    />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders table tags', () => {
    const thTags = instance.findAllByType('th');
    expect(thTags).toBeDefined();
    expect(thTags.length).toEqual(6);
  });
});
