import React from 'react';
import { shallow } from 'enzyme';
import { CanvasAuth } from './canvas_auth';

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
    const result = shallow(
      <CanvasAuth {...props} />
    );
    const h1 = result.find('h1');
    expect(h1.props().children).toContain('Authorize with Canvas');
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
    const result = shallow(
      <CanvasAuth {...props} />
    );
    const h1 = result.find('h1');
    expect(h1.props().children).toContain('Canvas API Error');
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
    const result = shallow(
      <CanvasAuth {...props} />
    );
    const h1 = result.find('h1');
    expect(h1.props().children).toContain('Authorize with Canvas');
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
    const result = shallow(
      <CanvasAuth {...props} />
    );
    expect(result.isEmptyRender()).toEqual(true);
  });

});
