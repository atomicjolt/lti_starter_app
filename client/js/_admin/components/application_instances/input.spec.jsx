import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import Input         from './input';

describe('input', () => {

  let result;
  const props = {
    inputProps: {
      id: 'IM AN ID',
      value: 'IM A VALUE',
      checked: true,
      name: 'the name',
      type: 'radio',
      onChange: () => {},
    },
    className: 'imaclass',
    labelText: 'IMA LABEL',
  };

  describe('text', () => {

    beforeEach(() => {
      props.inputProps.type = 'text';
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Input {...props} />
        </Stub>
      );
    });

    it('renders the input with the correct attributes', () => {
      const input =  TestUtils.findRenderedDOMComponentWithTag(result, 'input');
      expect(input.getAttribute('type')).toBe('text');
    });

    it('renders text before the text input', () => {
      const label =  TestUtils.findRenderedDOMComponentWithTag(result, 'label');
      expect(label.children[0].textContent).toBe('IMA LABEL');
    });

  });

  describe('radio', () => {

    beforeEach(() => {
      props.inputProps.type = 'radio';
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Input {...props} />
        </Stub>
      );
    });

    it('renders the label text', () => {
      const label =  TestUtils.findRenderedDOMComponentWithTag(result, 'label');
      expect(label.textContent).toContain('IMA LABEL');
    });

    it('renders the input with the correct attributes', () => {
      const input =  TestUtils.findRenderedDOMComponentWithTag(result, 'input');
      expect(input.getAttribute('id')).toBe('IM AN ID');
      expect(input.getAttribute('value')).toBe('IM A VALUE');
      expect(input.getAttribute('name')).toBe('the name');
      expect(input.getAttribute('type')).toBe('radio');
      expect(input.checked).toBe(true);
    });

    it('renders text after the radio input', () => {
      const label =  TestUtils.findRenderedDOMComponentWithTag(result, 'label');
      expect(label.children[1].textContent).toBe('IMA LABEL');
    });

  });

});
