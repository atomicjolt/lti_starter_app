import React        from 'react';
import TestUtils    from 'react-dom/test-utils';
import { Provider }     from 'react-redux';
import Helper           from '../../../../specs_support/helper';
import AccountInstall   from './account_install';

describe('lti installs account install', () => {

  let result;
  const accountInstalls = 123;
  const accountName = 'accountName';

  describe('with account present', () => {
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
        canvasRequest:     () => {},
        accountInstalls,
        account,
      };

      result = TestUtils.renderIntoDocument(
        <Provider store={Helper.makeStore()}>
          <AccountInstall {...props} />
        </Provider>
      );
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });

    it('renders a header', () => {
      const h1 = TestUtils.findRenderedDOMComponentWithTag(result, 'h1');
      expect(h1.textContent).toBe('123');
    });

    it('renders a header h3', () => {
      const h3 = TestUtils.findRenderedDOMComponentWithTag(result, 'h3');
      expect(h3.textContent).toBe(accountName);
    });

    it('renders buttons', () => {
      const accountButton = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(accountButton.textContent).toBe('Install Into Account');
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

      result = TestUtils.renderIntoDocument(
        <Provider store={Helper.makeStore()}>
          <AccountInstall {...props} />
        </Provider>
      );
    });

    it('renders a header h3', () => {
      const h3 = TestUtils.findRenderedDOMComponentWithTag(result, 'h3');
      expect(h3.textContent).toBe('Root');
    });

    it('renders buttons', () => {
      const accountButton = TestUtils.findRenderedDOMComponentWithTag(result, 'button');
      expect(accountButton.textContent).toBe('Install Into Account');
    });
  });
});
