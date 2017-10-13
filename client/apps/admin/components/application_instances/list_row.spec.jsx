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

  it('deletes the application instance', () => {
    expect(deleted).toBeFalsy();
    result.find('.c-delete').simulate('click');
    expect(deleted).toBeTruthy();
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
