import React        from 'react';
import TestUtils    from 'react-addons-test-utils';
import _ from 'lodash';
import Stub         from '../../../../specs_support/stub';
import Form         from './form';

describe('applications form', () => {

  let result;
  let props;
  let didSave;
  let didClose;

  beforeEach(() => {
    didClose = false;
    didSave = false;
    props = {
      onChange    : () => {},
      closeModal  : () => { didClose = true; },
      save        : () => { didSave = true; },
      description : 'SPEC_DESCRIPTION',
      defaultConfig: '{ "foo": "bar" }',
    };

    result = TestUtils.renderIntoDocument(
      <Stub>
        <Form {...props} />
      </Stub>
    );
  });

  it('did save', () => {
    const button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-btn c-btn--yellow');
    TestUtils.Simulate.click(button);
    expect(didSave).toBeTruthy();
  });

  it('close modal', () => {
    const button = TestUtils.findRenderedDOMComponentWithClass(result, 'c-btn c-btn--gray--large u-m-right');
    TestUtils.Simulate.click(button);
    expect(didClose).toBeTruthy();
  });

  it('renders description', () => {
    const element = TestUtils.findRenderedDOMComponentWithClass(result, 'o-grid o-grid__modal-top');
    expect(element).toBeDefined();
    const childDivs = element.childNodes;
    const inputTag = childDivs[0].firstChild.childNodes[1];
    expect(inputTag.value).toContain('SPEC_DESCRIPTION');
  });

  it('renders default config', () => {
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'textarea');
    const input = _.find(inputs, { id: 'application_default_config' });
    expect(input).toBeDefined();
    expect(input.value).toBe('{ "foo": "bar" }');
  });
});
