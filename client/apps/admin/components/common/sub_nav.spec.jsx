import React from 'react';
import { shallow } from 'enzyme';
import SubNav from './sub_nav';

describe('sub nav', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      sites: {
        1: {
          id: 1,
          oauth_key: 'akey',
          oauth_secret: 'secret',
        },
      },
    };
    result = shallow(<SubNav {...props} />);
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders a warning appropriately with empty sites', () => {
    expect(result.find('Link').last().props().children[1]).toBe(null);
    props.sites = {};
    result = shallow(<SubNav {...props} />);
    expect(result.find('Link').length).toEqual(2);
    const link = result.find('Link').last();
    expect(link.props().children[1]).not.toBe(null);
    expect(link.props().children[1]).toEqual(
      <span className="c-alert c-alert--danger"> ! Setup Required</span>
    );
  });

  it('renders a warning appropriately with empty oauth key', () => {
    expect(result.find('Link').last().props().children[1]).toBe(null);
    props.sites = {
      1: {
        id: 1,
        oauth_key: '',
        oauth_secret: 'secret',
      },
    };
    result = shallow(<SubNav {...props} />);
    expect(result.find('Link').length).toEqual(2);
    const link = result.find('Link').last();
    expect(link.props().children[1]).not.toBe(null);
    expect(link.props().children[1]).toEqual(
      <span className="c-alert c-alert--danger"> ! Setup Required</span>
    );
  });

  it('renders a warning appropriately with empty oauth secret', () => {
    expect(result.find('Link').last().props().children[1]).toBe(null);
    props.sites = {
      1: {
        id: 1,
        oauth_key: 'akey',
        oauth_secret: '',
      },
    };
    result = shallow(<SubNav {...props} />);
    expect(result.find('Link').length).toEqual(2);
    const link = result.find('Link').last();
    expect(link.props().children[1]).not.toBe(null);
    expect(link.props().children[1]).toEqual(
      <span className="c-alert c-alert--danger"> ! Setup Required</span>
    );
  });
});
