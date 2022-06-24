import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils, { act } from 'react-dom/test-utils';
import Input from './input';

describe('input', () => {
  let result;
  let changed;

  const inputProps = {
    id: 'IM AN ID',
    value: 'IM A VALUE',
    checked: true,
    name: 'the name',
    type: 'radio',
    onChange: () => { changed = true; },
  };
  const className = 'imaclass';
  const labelText = 'IMA LABEL';

  beforeEach(() => {
    changed = false;
    result = TestRenderer.create(
      <Input
        inputProps={inputProps}
        className={className}
        labelText={labelText}
      />);
  });

  it('matches the snapshot', () => {
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange function', () => {
    expect(changed).toBeFalsy();

    const container = document.createElement('div');
    document.body.appendChild(container);
    act(() => {
      ReactDOM.render(
        <Input
          inputProps={inputProps}
          className={className}
          labelText={labelText}
        />,
        container
      );
    });
    const inputs = document.getElementsByTagName('input');
    expect(inputs.length).toEqual(1);
    const input = inputs[0];
    const event = { target: { value: 'test onChange' } };
    ReactTestUtils.Simulate.change(input, event);

    expect(changed).toBeTruthy();
  });
});
