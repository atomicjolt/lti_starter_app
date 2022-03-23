import React from 'react';
import TestRenderer from 'react-test-renderer';
import Header from './header';

describe('application instances header', () => {
  let result;
  let props;
  let newLtiKey;

  beforeEach(() => {
    newLtiKey = false;
    props = {
      application: {
        name: 'test application',
      },
      newLtiInstallKey: () => { newLtiKey = true; },
    };
    result = TestRenderer.create(<Header {...props} />);
  });

  it('handles the onClick function', () => {
    expect(newLtiKey).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(newLtiKey).toBeTruthy();
  });
});
