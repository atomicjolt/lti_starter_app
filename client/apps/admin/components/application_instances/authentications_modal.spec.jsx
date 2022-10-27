import React from 'react';
import TestRenderer from 'react-test-renderer';

import { authentications_modal } from './authentications_modal';

describe('authentications_modal', () => {
  it('renders the authentications_modal component', () => {
    const result = TestRenderer.create(
        <authentications_modal />
    );
    expect(result).toMatchSnapshot();
  });
});
