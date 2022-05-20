import React from 'react';
import TestRenderer from 'react-test-renderer';
import AccountInstall from './account_install';

describe('lti installs account install', () => {

  let result;
  let instance;
  const accountInstalls = 123;
  const accountName = 'accountName';
  let clicked;

  const applicationInstance = {
    lti_key: 'lti_key'
  };
  const canvasRequest = () => { clicked = true; };

  describe('with account present', () => {
    clicked = false;
    beforeEach(() => {
      const account = {
        id: 12,
        name: accountName,
        external_tools: {
          consumer_key: 'consumer_key'
        }
      };

      result = TestRenderer.create(
        <AccountInstall
          applicationInstance={applicationInstance}
          canvasRequest={canvasRequest}
          accountInstalls={accountInstalls}
          account={account}
        />);
      instance = result.root;
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('matches the snapshot', () => {
      expect(result).toMatchSnapshot();
    });

    it('handles the button click', () => {
      expect(clicked).toBeFalsy();
      instance.findByType('button').props.onClick();
      expect(clicked).toBeTruthy();
    });
  });

  describe('with account present', () => {
    beforeEach(() => {
      result = TestRenderer.create(
        <AccountInstall
          applicationInstance={applicationInstance}
          canvasRequest={canvasRequest}
          accountInstalls={accountInstalls}
        />);
      instance = result.root;
    });

    it('renders a header h3', () => {
      const h3 = instance.findByType('h3');
      expect(h3.props.children).toBe('Root');
    });

    it('renders buttons', () => {
      const accountButton = instance.findByType('button');
      expect(accountButton.props.children).toBe('Install Into Account');
    });
  });
});
