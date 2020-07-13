import React from 'react';
import { shallow } from 'enzyme';
import List from './list';

describe('application instances list', () => {
  let result;
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
    result = shallow(<List {...props} />);
  });

  it('renders table tags', () => {
    const thTags = result.find('th');
    expect(thTags).toBeDefined();
    expect(thTags.length).toEqual(2);
  });
});
