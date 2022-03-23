import React from 'react';
import TestRenderer from 'react-test-renderer';
import AccountInstall from './account_install';

describe('lti installs account install', () => {

  let result;
  const accountInstalls = 123;
  const accountName = 'accountName';
  let clicked;

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

      const props = {
        applicationInstance: {
          lti_key: 'lti_key'
        },
        canvasRequest: () => { clicked = true; },
        accountInstalls,
        account,
      };

      result = TestRenderer.create(<AccountInstall {...props} />);
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
      const props = {
        applicationInstance: {
          lti_key: 'lti_key'
        },
        canvasRequest:     () => {},
        accountInstalls,
      };

      result = TestRenderer.create(<AccountInstall {...props} />);
    });

    it('renders a header h3', () => {
      const h3 = instance.findByType('h3');
      expect(h3.props().children).toBe('Root');
    });

    it('renders buttons', () => {
      const accountButton = instance.findByType('button');
      expect(accountButton.props().children).toBe('Install Into Account');
    });
  });
});
