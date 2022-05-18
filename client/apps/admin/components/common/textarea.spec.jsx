import React from 'react';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils from 'react-dom/test-utils';
import Textarea from './textarea';

describe('textarea', () => {
  let result;
  let changed;
  let instance;

  const onChange = () => {
    changed = true;
  };

  const textareaprops = {
    id: 'IM AN ID',
    value: 'IM A VALUE',
    disabled: false,
    name: 'the name',
    placeholder: 'IMA PLACEHOLDER',
    maxLength: 1,
    minLength: 1,
    cols: 3,
    rows: 2,
    onChange,
  };

  const className = 'imaclass';
  const labelText = 'IMA LABEL';

  beforeEach(() => {
    changed = false;
    result = TestRenderer.create(<Textarea
      textareaProps={textareaprops}
      className={className}
      labelText={labelText}
    />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange event', () => {
    const event = { target: { value: 'test onChange' } };
    const textarea = instance.findByType('textarea');
    expect(changed).toBeFalsy();
    ReactTestUtils.Simulate.change(textarea, event);
    // instance.findByType('input').simulate('change'); // original way it was done in code
    expect(changed).toBeTruthy();
  });
});
