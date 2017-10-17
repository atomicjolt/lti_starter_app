import React from 'react';
import { shallow } from 'enzyme';
import Header from './header';

describe('sites header', () => {
  let result;
  let props;
  let clicked;

  beforeEach(() => {
    clicked = false;
    props = {
      newSite: () => { clicked = true; },
    };

    result = shallow(<Header {...props} />);
  });

  it('renders the header', () => {
    const h1 = result.find('h1');
    expect(h1.props().children).toContain('Sites');
  });

  it('renders new site button', () => {
    const button = result.find('button');
    expect(button.props().children).toBe('New Site');
  });

  it('handles the onClick event', () => {
    expect(clicked).toBeFalsy();
    result.find('button').simulate('click');
    expect(clicked).toBeTruthy();
  });
});
