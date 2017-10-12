import React from 'react';
import { shallow } from 'enzyme';
import Textarea from './textarea';

describe('textarea', () => {
  let result;
  let props;
  let changed;

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
    result = shallow(<Textarea {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange event', () => {
    expect(changed).toBeFalsy();
    result.find('textarea').simulate('change');
    expect(changed).toBeTruthy();
  });
});
