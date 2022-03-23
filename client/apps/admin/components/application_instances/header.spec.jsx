import React from 'react';
import TestRenderer from 'react-test-renderer';
import Header from './header';

describe('application instances header', () => {
  let result;
  let instance;
  let props;
  let newInstance;

  beforeEach(() => {
    newInstance = false;
    props = {
      application: {
        name: 'test application',
      },
      newApplicationInstance: () => { newInstance = true; },
    };
    result = TestRenderer.create(<Header {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onClick function', () => {
    expect(newInstance).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(newInstance).toBeTruthy();
  });
});
