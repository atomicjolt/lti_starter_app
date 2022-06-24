import React from 'react';
import TestRenderer from 'react-test-renderer';
import { Provider } from 'react-redux';
import configureStore from 'redux-mock-store';
import { CanvasAuth } from './canvas_auth';

const mockStore = configureStore([]);
const store = mockStore({});

describe('Canvas Auth', () => {
  it('renders the reauthorization when reauthorization is required', () => {
    const props = {
      canvasReAuthorizationRequired: true,
      settings: {
        canvas_auth_required: false,
        is_context_admin: true,
        lti_message_type: '',
        has_global_auth: false,
      },
      errors: [],
      addError: () => {},
    };
    const result = TestRenderer.create(
      <Provider store={store}>
        <CanvasAuth {...props} />
      </Provider>
    );
    const h1 = result.root.findByType('h1');
    expect(h1.props.children).toContain('Authorize with Canvas');
  });

  it('renders an token error message when global auth is invalid', () => {
    const props = {
      canvasReAuthorizationRequired: true,
      settings: {
        canvas_auth_required: false,
        is_context_admin: true,
        lti_message_type: '',
        has_global_auth: true,
      },
      errors: [],
      addError: () => {},
    };
    const result = TestRenderer.create(
      <Provider store={store}>
        <CanvasAuth {...props} />
      </Provider>
    );
    const h1 = result.root.findByType('h1');
    expect(h1.props.children).toContain('Canvas API Error');
  });

  it('renders the authorization when authorization is required', () => {
    const props = {
      canvasReAuthorizationRequired: false,
      settings: {
        canvas_auth_required: true,
        is_context_admin: true,
        lti_message_type: '',
        has_global_auth: false,
      },
      errors: [],
      addError: () => {},
    };
    const result = TestRenderer.create(
      <Provider store={store}>
        <CanvasAuth {...props} />
      </Provider>
    );
    const h1 = result.root.findByType('h1');
    expect(h1.props.children).toContain('Authorize with Canvas');
  });

  it('renders nothing when no authorization is required', () => {
    const props = {
      canvasReAuthorizationRequired: false,
      settings: {
        canvas_auth_required: false,
        is_context_admin: true,
        lti_message_type: '',
        has_global_auth: true,
      },
      errors: [],
      addError: () => {},
    };
    const result = TestRenderer.create(
      <Provider store={store}>
        <CanvasAuth {...props} />
      </Provider>
    );
    expect(result.toJSON()).toEqual('');
  });

});
