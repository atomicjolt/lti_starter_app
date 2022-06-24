import React from 'react';
import TestRenderer from 'react-test-renderer';
import Header from './header';

describe('application instances header', () => {
  let result;
  let newLtiKey;
  let instance;

  const application = {
    name: 'test application',
  };
  const newLtiInstallKey = () => { newLtiKey = true; };

  beforeEach(() => {
    newLtiKey = false;
    result = TestRenderer.create(<Header
      application={application}
      newLtiInstallKey={newLtiInstallKey}
    />);
    instance = result.root;
  });

  it('handles the onClick function', () => {
    expect(newLtiKey).toBeFalsy();
    instance.findByType('button').props.onClick();
    expect(newLtiKey).toBeTruthy();
  });
});
