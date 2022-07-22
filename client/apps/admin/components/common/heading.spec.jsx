import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Heading } from './heading';

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
    result = TestRenderer.create(<Heading {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
