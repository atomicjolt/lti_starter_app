import _ from 'lodash';
import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { ContentItemSelectionForm } from './content_item_selection_form';
import Stub from '../../../specs_support/stub';

describe('Content Item Selection Form', () => {
  it('renders and submits a form to submit a content item response', () => {
    const settings = {
      canvas_oauth_url: 'http://www.example.com'
    };
    const result = TestUtils.renderIntoDocument(
      <Stub><ContentItemSelectionForm settings={settings} /></Stub>
    );
    const inputs = TestUtils.scryRenderedDOMComponentsWithTag(result, 'input');
    const foundAuthorize = _.find(inputs, input => input.value === 'Authorize');
    expect(_.isUndefined(foundAuthorize)).toBe(false);
  });
});
