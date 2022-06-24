import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import Sidebar from './sidebar';

const mockStore = configureStore([]);
const store = mockStore({});

describe('lti installs sidebar', () => {
  let result;
  let instance;
  const applicationName = 'applicationName';
  const accounts = {
    1: {
      id: 1,
      name: 'accountName',
      sub_accounts: []
    }
  };
  const application = {
    name: applicationName
  };
  const applicationInstance = {
    site: {
      url: 'www.atomicjolt.com'
    }
  };
  const saveApplicationInstance = () => {};
  const canvasRequest = () => {};
  const setAccountActive = () => {};
  const sites = {};

  describe('should render sidebar', () => {
    beforeEach(() => {
      result = TestRenderer.create(
        <Provider store={store}>
          <Sidebar
            accounts={accounts}
            application={application}
            applicationInstance={applicationInstance}
            saveApplicationInstance={saveApplicationInstance}
            canvasRequest={canvasRequest}
            setAccountActive={setAccountActive}
            sites={sites}
          />
        </Provider>
      );
      instance = result.root;
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });

    it('matches the snapshot', () => {
      expect(result).toMatchSnapshot();
    });

    it('return the title name', () => {
      const title = instance.findByProps({ className: 'c-tool__title' });
      expect(title.props.children).toBe(applicationName);
    });

    it('return the site url', () => {
      const title = instance.findByProps({ className: 'c-tool__instance' });
      expect(title.props.children.props.href).toEqual('www.atomicjolt.com');
    });

  });
});
