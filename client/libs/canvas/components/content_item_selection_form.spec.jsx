import _ from 'lodash';
import React from 'react';
import TestUtils from 'react-dom/test-utils';
import { ContentItemSelectionForm } from './content_item_selection_form';
import Stub from '../../../specs_support/stub';

describe('Content Item Selection Form', () => {
  it('renders and submits a form to submit a content item response', () => {
    const launchData = {};
    const contentItemReturnURL = 'http://www.example.com';
    const result = TestUtils.renderIntoDocument(
      <Stub>
        <ContentItemSelectionForm
          launchData={launchData}
          contentItemReturnURL={contentItemReturnURL}
        />
      </Stub>
    );
    const form = TestUtils.scryRenderedDOMComponentsWithTag(result, 'form');
    expect(_.isUndefined(form)).toBe(false);
  });
});
