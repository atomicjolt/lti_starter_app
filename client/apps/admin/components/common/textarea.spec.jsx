import React from 'react';
import TestRenderer from 'react-test-renderer';
import Textarea from './textarea';

describe('textarea', () => {
  let result;
  let props;
  let changed;
  let instance;

  beforeEach(() => {
    changed = false;
    props = {
      textareaProps: {
        id: 'IM AN ID',
        value: 'IM A VALUE',
        disabled: false,
        name: 'the name',
        placeholder: 'IMA PLACEHOLDER',
        maxLength: 1,
        minLength: 1,
        cols: 3,
        rows: 2,
        onChange: () => { changed = true; },
      },
      className: 'imaclass',
      labelText: 'IMA LABEL',
    };
    result = TestRenderer.create(<Textarea {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange event', () => {
    expect(changed).toBeFalsy();
    instance.findByType('textarea').simulate('change');
    expect(changed).toBeTruthy();
  });
});
