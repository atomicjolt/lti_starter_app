import React from 'react';
import { shallow } from 'enzyme';
import { Index } from './index';
import sites from '../../reducers/sites';

jest.mock('../../libs/assets');
describe('applications index', () => {

  let result;
  let props;
  const sitesData = { 1: { id: 1, oauth_key: 'akey', oauth_secret: 'secret' } };

  beforeEach(() => {
    props = {
      saveApplication: () => {},
      applications: {
        Spiderman: {
          Power1: 'Wall Crawling',
          Power2: 'Spidey Sense'
        }
      }
    };

    result = shallow(<Index {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
