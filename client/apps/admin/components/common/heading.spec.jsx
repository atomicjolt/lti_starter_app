import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import _            from 'lodash';
import Helper       from '../../../../specs_support/helper';
import Heading      from './heading';

describe('common heading', () => {
  let result;

  const props = {
    backTo: '/',
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Provider store={Helper.makeStore()}>
        <Heading {...props} />
      </Provider>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  describe('back button', () => {
    it('renders back button', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      const backButton = _.find(buttons, { textContent: 'Back' });
      expect(backButton).toBeDefined();
    });

    it('renders no back button', () => {
      result = TestUtils.renderIntoDocument(
        <Provider store={Helper.makeStore()}>
          <Heading />
        </Provider>
      );
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      const backButton = _.find(buttons, { textContent: 'Back' });
      expect(backButton).not.toBeDefined();
    });
  });

  describe('dropdown button', () => {
    it('has a presence', () => {
      const button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-username');
      expect(button.children[0].textContent).toBe('');
      expect(button.children[1].className).toBe('i-dropdown');
    });
  });

});
