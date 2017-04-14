import React from 'react';
import TestUtils from 'react-dom/test-utils';
import _ from 'lodash';
import Stub from '../../../../specs_support/stub';
import Form, { FIELDS } from './form';

describe('site form', () => {
  let result;
  let props;
  let modalClosed = false;

  beforeEach(() => {
    props = {
      setupSite: () => {},
      closeModal: () => { modalClosed = true; },
      onChange: () => {},
      isUpdate: false,
    };
    result = TestUtils.renderIntoDocument(
      <Stub>
        <Form {...props} />
      </Stub>
    );
  });

  it('renders the form', () => {
    expect(result).toBeDefined();
  });

  describe('text fields', () => {
    _.each(FIELDS, (fieldLabel, field) => {
      it('renders the field', () => {
        const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
        const input = _.find(inputs, { id: `site_${field}` });
        expect(input).toBeDefined();
        expect(input.name).toBe(field);
        expect(input.type).toBe('text');
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
