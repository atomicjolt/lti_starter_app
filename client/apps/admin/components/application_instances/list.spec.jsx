import React from 'react';
import TestRenderer from 'react-test-renderer';
import List from './list';

describe('application instances list', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      applicationInstances: [
        {
          id: 4,
          application_id: 7,
        },
      ],
      settings: {},
      application: {},
      canvasOauthURL: 'https://example.com',
      disableApplicationInstance: () => {},
      deleteApplicationInstance: () => {},
      saveApplicationInstance: () => {},
      sites: { 1: { id: 1, url: 'http://www.example.com' } },
      currentSortColumn: '',
      currentSortDirection: '',
      setSort: () => {},
    };
    result = TestRenderer.create(<List {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
