import React from 'react';
import { shallow } from 'enzyme';
import { Index } from './index';

describe('layout index', () => {
  let result;

  let getSites = false;
  let getApplications = false;

  let props;

  const text = 'hello';
  const children = <h1>{text}</h1>;

  beforeEach(() => {
    props = {
      children,
      getApplications: () => { getApplications = true; },
      getSites: () => { getSites = true; },
      location: {
        pathname: '/'
      },
    };
    result = shallow(<Index {...props} />);
  });

  it('renders the index', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('Loads sites', () => {
    result.instance().componentDidMount();
    expect(getSites).toBe(true);
  });

  it('Loads applications', () => {
    expect(getApplications).toBe(true);
  });
});
