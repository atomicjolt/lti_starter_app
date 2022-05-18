import React from 'react';
import TestRenderer from 'react-test-renderer';
import Header from './header';

describe('sites header', () => {
  let result;
  let clicked;
  let instance;

  const newSite = () => {
    clicked = true;
  };

  beforeEach(() => {
    clicked = false;
    result = TestRenderer.create(<Header newSite={newSite} />);
    instance = result.root;
  });

  it('renders the header', () => {
    const h1 = instance.findByType('h1');
    expect(h1.props.children).toContain('Sites');
  });

  it('renders new site button', () => {
    const button = instance.findByType('button');
    expect(button.props.children).toBe('New Site');
  });

  it('handles the onClick event', () => {
    expect(clicked).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(clicked).toBeTruthy();
  });
});
