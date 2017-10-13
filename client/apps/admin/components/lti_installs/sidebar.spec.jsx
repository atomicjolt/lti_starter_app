import React from 'react';
import { shallow } from 'enzyme';
import Sidebar from './sidebar';

describe('lti installs sidebar', () => {

  let result;
  let changed;
  const applicationName = 'applicationName';

  describe('should render sidebar', () => {
    changed = false;
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
        onlyShowInstalledChanged: () => { changed = true; },
      };
      result = shallow(<Sidebar {...props} />);
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
      const title = result.find('.c-tool__title');
      expect(title.props().children).toBe(applicationName);
    });

    it('return the site url', () => {
      const title = result.find('.c-tool__instance');
      expect(title.props().children).toEqual(
        <a href="www.atomicjolt.com">www.atomicjolt.com</a>
      );
    });

    it('handles the onChange for input', () => {
      expect(changed).toBeFalsy();
      const input = result.find('input');
      input.simulate('change');
      expect(changed).toBeTruthy();
    });
  });
});
