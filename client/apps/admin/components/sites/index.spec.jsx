import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Index } from './index';

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
      deleteSite: () => {},
    };
    result = TestRenderer.create(<Index {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });
});
