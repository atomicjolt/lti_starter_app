import React from 'react';
import TestRenderer from 'react-test-renderer';
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

    result = TestRenderer.create(<Header {...props} />);
  });

  it('renders the header', () => {
    const h1 = instance.findByType('h1');
    expect(h1.props().children).toContain('Sites');
  });

  it('renders new site button', () => {
    const button = instance.findByType('button');
    expect(button.props().children).toBe('New Site');
  });

  it('handles the onClick event', () => {
    expect(clicked).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(clicked).toBeTruthy();
  });
});
