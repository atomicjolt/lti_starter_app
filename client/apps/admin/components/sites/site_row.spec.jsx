import React from 'react';
import { shallow } from 'enzyme';
import SiteRow from './site_row';

describe('sites list row', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      site: { url: 'http://www.example.com' },
    };
    result = shallow(<SiteRow {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the first button onclick event', () => {
    expect(result.instance().state.siteModalOpen).toBeFalsy();
    result.find('button').at(0).simulate('click');
    expect(result.instance().state.siteModalOpen).toBeTruthy();
  });

  it('handles the second button onclick event', () => {
    const button = result.find('button');
    expect(result.instance().state.confirmDeleteModalOpen).toBeFalsy();
    button.at(1).simulate('click');
    expect(result.instance().state.confirmDeleteModalOpen).toBeTruthy();
  });
});
