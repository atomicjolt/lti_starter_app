import React from 'react';
import { Link } from 'react-router3';
import TestRenderer from 'react-test-renderer';
import SubNav from './sub_nav';


function findText(testRenderer, text) {
  return JSON.stringify(testRenderer.toJSON()).indexOf(text) >= 0;
}

describe('sub nav', () => {
  const alertText = '! Setup Required';
  let testRenderer;
  let testInstance;
  let json;

  beforeEach(() => {
    const sites = {
      1: {
        id: 1,
        oauth_key: 'akey',
        oauth_secret: 'secret',
      },
    };
    testRenderer = TestRenderer.create(
      <SubNav sites={sites} />
    );
    testInstance = testRenderer.root;
    json = testRenderer.toJSON();
  });

  it('renders', () => {
    expect(testRenderer).toBeDefined();
    expect(testInstance.findAllByType(Link).length).toEqual(2);
  });

  it('matches the snapshot', () => {
    expect(json).toMatchSnapshot();
  });

  it('renders a warning appropriately with empty sites', () => {
    testRenderer = TestRenderer.create(
      <SubNav sites={{}} />
    );
    expect(findText(testRenderer, alertText)).toBe(true);
  });

  it('renders a warning appropriately with empty oauth key', () => {
    const sites = {
      1: {
        id: 1,
        oauth_key: '',
        oauth_secret: 'secret',
      },
    };
    testRenderer = TestRenderer.create(
      <SubNav sites={sites} />
    );
    expect(findText(testRenderer, alertText)).toBe(true);
  });

  it('renders a warning appropriately with empty oauth secret', () => {
    const sites = {
      1: {
        id: 1,
        oauth_key: 'akey',
        oauth_secret: '',
      },
    };
    testRenderer = TestRenderer.create(
      <SubNav sites={sites} />
    );
    expect(findText(testRenderer, alertText)).toBe(true);
  });
});
