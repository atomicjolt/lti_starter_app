import React from 'react';
import TestRenderer from 'react-test-renderer';
import SettingsInputs from './settings_inputs';

describe('common search inputs', () => {
  let result;
  let instance;
  let props;
  const ltiKey = 'lti_key';
  const ltiName = 'ltiName';

  beforeEach(() => {
    props = {
      settings: {
        lti_key: ltiKey,
        name: ltiName,
      },
    };
    result = TestRenderer.create(<SettingsInputs {...props} />);
    instance = result.root;
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('has hidden input', () => {
    const input = instance.findAllByType('input')[0];
    expect(input).toBeDefined();
    expect(input.props.type).toBe('hidden');
    expect(input.props.value).toBe(ltiKey);
  });

  it('adds settings as params', () => {
    const ltiKeyInput = instance.findAllByType('input')[0];
    expect(ltiKeyInput).toBeDefined();
    expect(ltiKeyInput.props.type).toBe('hidden');
    expect(ltiKeyInput.props.value).toBe(ltiKey);

    const ltiNameInput = instance.findAllByType('input')[1];
    expect(ltiNameInput).toBeDefined();
    expect(ltiNameInput.props.type).toBe('hidden');
    expect(ltiNameInput.props.value).toBe(ltiName);
  });
});
