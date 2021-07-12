import React from 'react';
import { shallow } from 'enzyme';
import { Heading } from './heading';

jest.mock('../../libs/assets');
describe('common heading', () => {
  let result;
  let props;
  const sites = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  beforeEach(() => {
    props = {
      backTo: '/',
      userName: 'username',
      signOutUrl: 'https://www.example.com',
      sites,
    };
    result = shallow(<Heading {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
