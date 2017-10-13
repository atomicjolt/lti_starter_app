import React from 'react';
import { shallow } from 'enzyme';
import { Index } from './index';
import sites from '../../reducers/sites';

jest.mock('../../libs/assets');
describe('sites index', () => {
  let result;
  let props;

  const sitesData = {
    1: {
      id: 1,
      url: 'bfcoder.com'
    },

    2: {
      id: 2,
      url: 'atomicjolt.com'
    }
  };
  
  beforeEach(() => {
    props = {
      sites: sitesData,
    };
    result = shallow(<Index {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
