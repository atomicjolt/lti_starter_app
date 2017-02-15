import _               from 'lodash';
import React           from 'react';
import TestUtils       from 'react-addons-test-utils';
import Form,
       { TEXT_FIELDS,
         TYPE_RADIOS } from './form';

describe('application instance form', () => {
  let result;
  let props;
  let modalClosed = false;

  beforeEach(() => {
    props = {
      onChange:       () => {},
      closeModal:     () => { modalClosed = true; },
      createInstance: () => {},
      newSite:        () => {},
      site_id:        'foo',
      sites:          {},
    };
    result = TestUtils.renderIntoDocument(
      <Form {...props} />
    );
  });

  it('renders the form', () => {
    expect(result).toBeDefined();
  });

  describe('text fields', () => {
    _.each(TEXT_FIELDS, (fieldLabel, field) => {
      it('renders the field', () => {
        const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
        const input = _.find(inputs, { id: `instance_${field}` });
        expect(input).toBeDefined();
        expect(input.name).toBe(field);
        expect(input.type).toBe('text');
      });
    });
  });

  describe('radio fields', () => {
    _.each(TYPE_RADIOS, (fieldLabel, field) => {
      it('renders the field', () => {
        const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
        const input = _.find(inputs, { id: `instance_${field}` });
        expect(input).toBeDefined();
        expect(input.name).toBe('lti_type');
        expect(input.value).toBe(field);
        expect(input.type).toBe('radio');
      });
    });
  });

  describe('close modal', () => {
    it('closes', () => {
      const buttons = TestUtils.scryRenderedDOMComponentsWithTag(result, 'button');
      const modalButton = _.find(buttons, { textContent: 'Cancel' });
      TestUtils.Simulate.click(modalButton);
      expect(modalClosed).toBe(true);
    });
  });

});
