import React from 'react';
import _ from 'lodash';
import TestUtils from 'react-dom/test-utils';
import Stub from '../../../../specs_support/stub';
import ConfigXmlModal from './config_xml_modal';

describe('config xml modal', () => {
  let result;
  let props;

  beforeEach(() => {
    props = {
      isOpen: true,
      closeModal: () => {},
      application: {
        id: 1,
        name: 'bfcoder',
      },
      applicationInstance: {
        id: 1,
        lti_key: 'something-special',
        lti_secret: '12345',
        lti_config_xml: 'IMA XML',
      },
    };
    result = TestUtils.renderIntoDocument(
      <Stub>
        <ConfigXmlModal {...props} />
      </Stub>
    );
  });

  // TODO: find a way to reach into the ReactModal
  xit('renders a the lti_key', () => {
    const divs = TestUtils.scryRenderedDOMComponentsWithClass(result, 'o-grid__item');
    const found = _.includes(divs, div => div.textContent === 'something-special');
    expect(found).toBeTruthy();
  });

  xit('renders a the lti_secret', () => {
    const divs = TestUtils.scryRenderedDOMComponentsWithClass(result, 'o-grid__item');
    const found = _.includes(divs, div => div.textContent === '12345');
    expect(found).toBeTruthy();
  });

  xit('renders a the lti_key', () => {
    const divs = TestUtils.scryRenderedDOMComponentsWithClass(result, 'o-grid__item');
    const found = _.includes(divs, div => div.textContent === 'IMA XML');
    expect(found).toBeTruthy();
  });
});
