import React            from 'react';
import TestUtils        from 'react-addons-test-utils';
import _                from 'lodash';
import Stub             from '../../../../specs_support/stub';
import SettingsInputs   from './settings_inputs';

describe('common search inputs', () => {
  let result;
  const ltiKey = 'lti_key';
  const ltiName = 'ltiName';

  const props = {
    settings: {
      lti_key: ltiKey,
      name: ltiName,
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
    expect(input.value).toBe(ltiKey);
  });

  it('search input changes', () => {
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const input = _.find(inputs, { name: 'lti_key' });
    expect(input).toBeDefined();
    expect(input.type).toBe('hidden');
    expect(input.value).toBe(ltiKey);
  });

  it('search input changes', () => {
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const input = _.find(inputs, { name: 'name' });
    expect(input).toBeDefined();
    expect(input.type).toBe('hidden');
    expect(input.value).toBe(ltiName);
  });

});
