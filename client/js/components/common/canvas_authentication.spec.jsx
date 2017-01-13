import React                    from 'react';
import TestUtils                from 'react-addons-test-utils';
import { CanvasAuthentication } from './canvas_authentication';
import Stub                     from '../../../specs_support/stub';

describe('Canvas authentication', () => {
  it('renders a button to authenticate with Canvas', () => {
    const result = TestUtils.renderIntoDocument(<Stub><CanvasAuthentication /></Stub>);
    const a = TestUtils.findRenderedDOMComponentWithTag(result, 'a');
    expect(a.textContent).toContain('Authorize Application');
  });
});
