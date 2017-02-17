import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import Stub         from '../../../../specs_support/stub';
import Form         from './form';

describe('applications form', () => {

  let result;
  let props;
  let action;

  beforeEach(() => {
    action = false;
    props = {
      onChange: () => {},
      closeModal: () => { action = true; },
      save: () => { action = true; },
      description: "SPEC_DESCRIPTION"
    };

    result = TestUtils.renderIntoDocument(
      <Stub>
        <Form {...props} />
      </Stub>
    );
  });

  it('renders a form', () => {
    let button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-btn c-btn--yellow');
    TestUtils.Simulate.click(button);
    expect(action).toBeTruthy();
  });

  it('close modal', () => {
    let button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-btn c-btn--gray--large u-m-right');
    TestUtils.Simulate.click(button);
    expect(action).toBeTruthy();
  });

  it('renders description', () => {
    let element = TestUtils.findRenderedDOMComponentWithClass(result, 'o-grid o-grid__modal-top');
    expect(element).toBeDefined();
    let childDivs = element.childNodes;
    let inputTag = childDivs[0].firstChild.childNodes[1];
    expect(inputTag.value).toContain('SPEC_DESCRIPTION');
  })
});