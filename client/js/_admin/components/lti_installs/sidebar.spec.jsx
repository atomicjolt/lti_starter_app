import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Sidebar      from './sidebar';

describe('lti installs sidebar', () => {

  let result;
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
        onlyShowInstalledChanged: () => {},
      };
      result = TestUtils.renderIntoDocument(
        <Sidebar {...props} />
      );
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });

    it('return the title name', () => {
      const title = TestUtils.findRenderedDOMComponentWithClass(result, 'c-tool__title');
      expect(title.textContent).toBe(applicationName);
    });

    it('return the site url', () => {
      const title = TestUtils.findRenderedDOMComponentWithClass(result, 'c-tool__instance');
      expect(title.textContent).toBe('www.atomicjolt.com');
    });
  });
});
