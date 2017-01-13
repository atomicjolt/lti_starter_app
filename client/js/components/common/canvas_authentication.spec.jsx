import React                from 'react';
import TestUtils            from 'react-addons-test-utils';
import CanvasAuthentication from './canvas_authentication';
import Stub                 from '../../../specs_support/stub';

describe('Canvas authentication', () => {
  it('renders a button to authenticate with Canvas', () => {
    const result = TestUtils.renderIntoDocument(<Stub><CanvasAuthentication /></Stub>);
    const heading = TestUtils.findRenderedDOMComponentWithTag(result, 'h1');
    expect(heading.textContent).toContain('Page Not Found');
  });
});
