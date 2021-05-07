import React from 'react';
import { shallow } from 'enzyme';
import ListRow from './list_row';

describe('application instances list row', () => {
  let props;
  let result;

  beforeEach(() => {
    props = {
      save: () => {},
      lti_key: 'lti-key',
      domain: 'www.example.com',
      sites: { 1: { id: 1, url: 'http://www.example.com' } },
      applicationInstance: {
        site: { url: 'http://www.example.com' },
        id: 2,
        lti_key: 'lti-key',
        application_id: 23,
        authentications: [],
        request_stats: {
          day_1_requests: 1,
          day_7_requests: 1,
          day_30_requests: 1,
          day_1_launches: 1,
          day_7_launches: 1,
          day_30_launches: 1,
          day_1_users: 1,
          day_7_users: 1,
          day_30_users: 1,
          day_1_errors: 1,
          day_7_errors: 1,
          day_30_errors: 1,
        },
      },
      settings: {
        lti_key: 'lti-key',
        user_canvas_domains: [''],
      },
      canvasOauthURL: 'http://www.example.com',
    };
    result = shallow(<ListRow {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

});
