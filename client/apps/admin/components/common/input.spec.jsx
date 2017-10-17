import React from 'react';
import { shallow } from 'enzyme';
import Input from './input';

describe('input', () => {
  let result;
  let props;
  let changed;

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
    result = shallow(<Input {...props} />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange function', () => {
    expect(changed).toBeFalsy();
    result.find('input').simulate('change');
    expect(changed).toBeTruthy();
  });
});
