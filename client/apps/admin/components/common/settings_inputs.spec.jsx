import React from 'react';
import { shallow } from 'enzyme';
import SettingsInputs from './settings_inputs';

describe('common search inputs', () => {
  let result;
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
    result = shallow(<SettingsInputs {...props} />);
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
    const input = result.find('input').first();
    expect(input).toBeDefined();
    expect(input.props().type).toBe('hidden');
    expect(input.props().value).toBe(ltiKey);
  });

  it('adds settings as params', () => {
    const ltiKeyInput = result.find('input').first();
    expect(ltiKeyInput).toBeDefined();
    expect(ltiKeyInput.props().type).toBe('hidden');
    expect(ltiKeyInput.props().value).toBe(ltiKey);

    const ltiNameInput = result.find('input').last();
    expect(ltiNameInput).toBeDefined();
    expect(ltiNameInput.props().type).toBe('hidden');
    expect(ltiNameInput.props().value).toBe(ltiName);
  });
});
