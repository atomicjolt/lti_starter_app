import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import { Provider } from 'react-redux';
import _            from 'lodash';
import Helper       from '../../../../specs_support/helper';
import Heading      from './heading';

describe('common heading', () => {
  let result;
  let back = false;

  const props = {
    back:         () => { back = true; },
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
    it('closes', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      const backButton = _.find(buttons, { textContent: 'Back' });
      expect(backButton).toBeDefined();
      TestUtils.Simulate.click(backButton);
      expect(back).toBe(true);
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
