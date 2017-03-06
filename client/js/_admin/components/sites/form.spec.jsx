import React from 'react';
import TestUtils from 'react-addons-test-utils';
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
      callbackUrl: '',
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

  describe('Canvas link', () => {
    it('displays not a link', () => {
      const links = TestUtils.scryRenderedDOMComponentsWithTag(result, 'a');
      expect(links.length).toBe(0);
    });

    it('displays a link', () => {
      props.url = 'https://example.com';
      result = TestUtils.renderIntoDocument(
        <Stub>
          <Form {...props} />
        </Stub>
      );
      const link = TestUtils.findRenderedDOMComponentWithTag(result, 'a');
      expect(link).toBeDefined();
      expect(link.text).toBe('Canvas Developer Keys');
      expect(_.includes(link.href, 'accounts/site_admin/developer_keys')).toBe(true);
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
