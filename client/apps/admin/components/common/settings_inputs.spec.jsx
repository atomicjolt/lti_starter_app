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

  it('search input changes', () => {
    const input = result.find('input').at(1);
    expect(input).toBeDefined();
    expect(input.props().type).toBe('hidden');
    expect(input.props().value).toBe(ltiKey);
  });

  it('search input changes', () => {
    const input = result.find('input').last();
    expect(input).toBeDefined();
    expect(input.props().type).toBe('hidden');
    expect(input.props().value).toBe(ltiName);
  });
});
