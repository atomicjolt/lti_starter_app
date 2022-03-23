import React from 'react';
import TestRenderer from 'react-test-renderer';
import Sidebar from './sidebar';

describe('lti installs sidebar', () => {
  let result;
  let instance;
  const applicationName = 'applicationName';

  describe('should render sidebar', () => {
    beforeEach(() => {
      const props = {
        accounts: {
          1: {
            id: 1,
            name: 'accountName',
            sub_accounts: []
          }
        },
        application: {
          name: applicationName
        },
        applicationInstance: {
          site: {
            url: 'www.atomicjolt.com'
          }
        },
        saveApplicationInstance: () => {},
        canvasRequest: () => {},
        setAccountActive: () => {},
        sites: {},
      };
      result = TestRenderer.create(<Sidebar {...props} />);
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
      const title = instance.findByProps({className: 'c-tool__title'});
      expect(title.props.children).toBe(applicationName);
    });

    it('return the site url', () => {
      const title = instance.findByProps({className: 'c-tool__instance'});
      expect(title.props.children.props.href).toEqual('www.atomicjolt.com');
    });

  });
});
