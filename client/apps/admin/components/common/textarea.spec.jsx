import React from 'react';
import ReactDOM from 'react-dom';
import TestRenderer from 'react-test-renderer';
import ReactTestUtils, { act } from 'react-dom/test-utils';
import Textarea from './textarea';

describe('textarea', () => {
  const onChange = jest.fn();
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

  it('matches the snapshot', () => {
    const result = TestRenderer.create(<Textarea
      textareaProps={textareaprops}
      className={className}
      labelText={labelText}
    />);
    expect(result).toMatchSnapshot();
  });

  it('handles the onChange event', () => {
    const container = document.createElement('div');
    document.body.appendChild(container);
    act(() => {
      ReactDOM.render(
        <Textarea
          textareaProps={textareaprops}
          className={className}
          labelText={labelText}
        />,
        container
      );
    });
    const textareas = document.getElementsByTagName('textarea');
    expect(textareas.length).toEqual(1);
    const textarea = textareas[0];
    const event = { target: { value: 'test onChange' } };
    ReactTestUtils.Simulate.change(textarea, event);
    expect(onChange).toHaveBeenCalledTimes(1);
  });
});
