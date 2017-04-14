import React from 'react';
import TestUtils from 'react-dom/test-utils';
import Stub from '../../../../specs_support/stub';
import Textarea from './textarea';

describe('textarea', () => {

  let result;
  const props = {
    textareaProps: {
      id: 'IM AN ID',
      value: 'IM A VALUE',
      name: 'the name',
      onChange: () => {},
    },
    className: 'imaclass',
    labelText: 'IMA LABEL',
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <Textarea {...props} />
      </Stub>
    );
  });

  it('renders the textarea with the correct attributes', () => {
    const textarea = TestUtils.findRenderedDOMComponentWithTag(result, 'textarea');
    expect(textarea.getAttribute('id')).toBe('IM AN ID');
  });

  it('renders text before the text textarea', () => {
    const label = TestUtils.findRenderedDOMComponentWithTag(result, 'label');
    expect(label.children[0].textContent).toBe('IMA LABEL');
  });

});
