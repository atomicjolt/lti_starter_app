import React            from 'react';
import TestUtils        from 'react-addons-test-utils';
import Stub             from '../../../../specs_support/stub';
import SettingsInputs   from './settings_inputs';

describe('common search inputs', () => {
  let result;
  let lti_key = 'lti_key';

  const props = {
    settings: {
      lti_key,
      name: 'lti_name',
    },
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <SettingsInputs {...props} />
      </Stub>
    );
  });

  it('renders', () => {
    expect(result).toBeDefined();
  });

  it('renders the form not null', () => {
    expect(result).not.toBeNull();
  });

  it('has hidden input', () => {
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const input = _.find(inputs, { name: 'oauth_consumer_key' });
    expect(input).toBeDefined();
    expect(input.type).toBe('hidden');
    expect(input.value).toBe(lti_key);
  });

  it('search input changes', () => {
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const input = _.find(inputs, { name: 'lti_key' });
    expect(input).toBeDefined();
    expect(input.type).toBe('hidden');
    expect(input.value).toBe(lti_key);
  });

  it('search input changes', () => {
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const input = _.find(inputs, { name: 'name' });
    expect(input).toBeDefined();
    expect(input.type).toBe('hidden');
    expect(input.value).toBe('lti_name');
  });

});
