import React from 'react';
import TestRenderer from 'react-test-renderer';

import { AuthenticationsModal } from './authentications_modal';

describe('AuthenticationsModal', () => {
  it('renders the AuthenticationsModal component', () => {
    const result = TestRenderer.create(
        <AuthenticationsModal />
    );
    expect(result).toMatchSnapshot();
  });
});
