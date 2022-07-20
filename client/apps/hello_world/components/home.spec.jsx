import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Home } from './home';

describe('home', () => {
  it('renders the home component', () => {
    const props = {
      canvasRequest: () => {},
      settings: {
        canvas_auth_required: false,
      },
    };
    const result = TestRenderer.create(<Home {...props} />);
    expect(result).toMatchSnapshot();
  });

});
