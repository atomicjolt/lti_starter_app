// //////////////////////////////////////////////////////////////////////////////////
// This is an example of how to implement LTI content item select
//

import _ from 'lodash';
import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

import ContentItemSelectionForm from '../../../../libs/lti/components/content_item_selection_form';
import { getContentItemSelection } from '../../actions/content_items';
import {
  embedHtml,
  embedMultipleHtml,
  ltiLaunch,
  embedIframe,
  embedLtiIframe,
  embedLtiIframeWriteBack,
} from '../../../../libs/lti/content_item_selection';

const select = state => ({
  acceptMediaTypes: state.settings.accept_media_types,
  contentItemReturnURL: state.settings.content_item_return_url,
  apiUrl : state.settings.api_url,
  contentItemSelection: state.contentItemSelection,
});

export class Selector extends React.Component {

  static propTypes = {
    getContentItemSelection: PropTypes.func,
    acceptMediaTypes: PropTypes.string,
    contentItemReturnURL: PropTypes.string,
    apiUrl: PropTypes.string,
    contentItemSelection: PropTypes.shape({}),
  };

  selectItem(contentItem) {

    this.props.getContentItemSelection(
      this.props.contentItemReturnURL,
      contentItem
    );
  }

  renderButton(text, acceptedType, contentItemFunc) {
    if (_.includes(this.props.acceptMediaTypes, acceptedType)) {
      return (
        <li>
          <button onClick={() => this.selectItem(contentItemFunc())}>
            {text}
          </button>
        </li>
      );
    }
    return null;
  }

  render() {

    if (!_.isEmpty(this.props.contentItemSelection)) {
      // ContentItemSelectionForm accepts launchData which is
      // an object of key value pairs that will be posted back to
      // the tool consumer. contentItemReturnURL is the url to post
      // back to.
      return (
        <ContentItemSelectionForm
          launchData={this.props.contentItemSelection}
          contentItemReturnURL={this.props.contentItemReturnURL}
        />
      );
    }

    return (
      <div>
        <h2>Select An Item:</h2>
        <ul>
          { this.renderButton(
              'Add Html',
              'text/html',
              () => embedHtml('<h1>Atomic Jolt</h1>')
          ) }
          { this.renderButton(
              'Add Multiple Html',
              'text/html',
              () => embedMultipleHtml('<h1>Atomic Jolt</h1>', '<h2>This is from the LTI starter app.</h2>')
          ) }
          { this.renderButton(
              'Add iFrame',
              'text/html',
              () => embedIframe(`${this.props.apiUrl}lti_launches`)
          ) }
          { this.renderButton(
              'Add LTI Link',
              'application/vnd.ims.lti.v1.ltilink',
              () => ltiLaunch('Atomic Jolt LTI Launch', `${this.props.apiUrl}lti_launches`)
          ) }
          { this.renderButton(
              'Add LTI Enabled iframe',
              'application/vnd.ims.lti.v1.ltilink',
              () => embedLtiIframe(`${this.props.apiUrl}lti_launches`)
          ) }
          { this.renderButton(
              'Add Outcome Enabled Assignment',
              'application/vnd.ims.lti.v1.ltilink',
              () => embedLtiIframeWriteBack('Atomic Outcome Assignment', `${this.props.apiUrl}lti_launches`)
          ) }
          { this.renderButton(
              'Add Image',
              'image/*',
              () => embedHtml(`${this.props.apiUrl}atomicjolt.png`)
          ) }
        </ul>
      </div>
    );
  }

}

export default connect(select, { getContentItemSelection })(Selector);
