import React from 'react';
import TestRenderer from 'react-test-renderer';
import Input from './input';

describe('input', () => {
  let result;
  let props;
  let changed;
  let instance;

  beforeEach(() => {
    changed = false;
    props = {
      inputProps: {
        id: 'IM AN ID',
        value: 'IM A VALUE',
        checked: true,
        name: 'the name',
        type: 'radio',
        onChange: () => { changed = true; },
      },
      className: 'imaclass',
      labelText: 'IMA LABEL',
    };
    result = TestRenderer.create(<Input {...props} />);
    instance = result.root;
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange function', () => {
    expect(changed).toBeFalsy();
    instance.findByType('input').simulate('change');
    expect(changed).toBeTruthy();
  });
});
