import React from 'react';
import { shallow } from 'enzyme';
import ListRow from './list_row';

describe('application instances list row', () => {
  let props;
  let result;
  let deleted;
  let disabled;

  beforeEach(() => {
    deleted = false;
    disabled = false;
    props = {
      delete: () => { deleted = true; },
      save: () => {},
      lti_key: 'lti-key',
      domain: 'www.example.com',
      sites: { 1: { id: 1, url: 'http://www.example.com' } },
      applicationInstance: {
        site: { url: 'http://www.example.com' },
        id: 2,
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
      disable: () => { disabled = true; },
    };
    result = shallow(<ListRow {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  // the following tests will break if the order of the buttopns is changed
  // to remedy this a class would need to be added to each button

  it('handles the opening of the modal', () => {
    expect(result.instance().state.modalOpen).toBeFalsy();
    const btn = result.find('button').first();
    btn.simulate('click');
    expect(result.instance().state.modalOpen).toBeTruthy();
  });

  it('handles the opening of the config modal', () => {
    expect(result.instance().state.modalConfigXmlOpen).toBeFalsy();
    const btn = result.find('button');
    btn.at(1).simulate('click');
    expect(result.instance().state.modalConfigXmlOpen).toBeTruthy();
  });

  it('handles the opening of the config modal', () => {
    expect(disabled).toBeFalsy();
    const btn = result.find('button');
    btn.at(2).simulate('click');
    expect(disabled).toBeTruthy();
  });
});
