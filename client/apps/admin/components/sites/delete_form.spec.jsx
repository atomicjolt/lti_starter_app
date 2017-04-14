import React from 'react';
import TestUtils from 'react-dom/test-utils';
import Stub from '../../../../specs_support/stub';
import DeleteForm from './delete_form';

describe('sites delete form', () => {
  let result;
  const props = {
    deleteSite: () => {},
    closeModal: () => {},
  };

  beforeEach(() => {
    result = TestUtils.renderIntoDocument(
      <Stub>
        <DeleteForm {...props} />
      </Stub>
    );
  });

  it('renders Yes button', () => {
    const button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-btn c-btn--red');
    expect(button.textContent).toContain('Yes');
  });

  it('renders Cancel button', () => {
    const button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-btn c-btn--gray--large');
    expect(button.textContent).toBe('Cancel');
  });

});
