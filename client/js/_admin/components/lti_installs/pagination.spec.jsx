import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import Pagination   from './pagination';

describe('lti installs pagination', () => {

  let result;

  describe('should render pagination', () => {
    beforeEach(() => {
      const props = {
        courses: [ {name: 'name', id: 1}, {name: 'name', id: 2} ],
        pageSize: 1,
        setPage: () => {},
        pageCount: 21,
        currentPage: 2
      };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Pagination {...props} />
        </Stub>
      );
    });

    it('renders', () => {
      expect(result).toBeDefined();
    });

    it('renders the form not null', () => {
      expect(result).not.toBeNull();
    });
  });

  describe('should not render pagination', () => {
    beforeEach(() => {
      const props = {
        courses: [],
        pageSize: 3,
        setPage: () => { settingPage = true; },
        pageCount: 21,
        currentPage: 2
      };
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Pagination {...props} />
        </Stub>
      );
    });

    it('return null with an empty div', () => {
      const divs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'div');
      expect(divs.length).toBe(1);
      expect(divs[0].children.length).toBe(0);
    });
  });

});
