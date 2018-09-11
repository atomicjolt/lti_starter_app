// //////////////////////////////////////////////////////////////////////////////////
// This is an example of how to implement LTI content item select
//

import _ from 'lodash';
import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import ContentItemSelectionForm from 'atomic-canvas/libs/lti/components/content_item_selection_form';

import {
  embedHtml,
  embedImage,
  embedMultipleHtml,
  ltiLaunch,
  embedIframe,
  embedLtiIframe,
  embedLtiIframeWriteBack,
} from 'atomic-canvas/libs/lti/content_item_selection';

import { createLtiLaunch } from '../../actions/lti_launches';
import { getContentItemSelection } from '../../actions/content_items';

const select = state => ({
  acceptMediaTypes: state.settings.accept_media_types,
  contentItemReturnURL: state.settings.content_item_return_url,
  apiUrl : state.settings.api_url,
  contentItemSelection: state.contentItemSelection,
  contextId: state.settings.context_id,
  toolConsumerInstanceGuid: state.settings.tool_consumer_instance_guid,
});

export class Selector extends React.Component {

  static propTypes = {
    getContentItemSelection: PropTypes.func,
    createLtiLaunch: PropTypes.func,
    acceptMediaTypes: PropTypes.string,
    contentItemReturnURL: PropTypes.string,
    apiUrl: PropTypes.string,
    contentItemSelection: PropTypes.shape({}),
    contextId: PropTypes.string,
    toolConsumerInstanceGuid: PropTypes.string,
  };

  selectItem(contentItem) {
    this.props.getContentItemSelection(
      this.props.contentItemReturnURL,
      contentItem
    );
  }

  generateLtiLaunch() {
    const config = { customName: 'Atomic Jolt' };
    const contentItem = embedLtiIframe(`${this.props.apiUrl}lti_launches`);
    this.props.createLtiLaunch(
      config,
      this.props.contentItemReturnURL,
      contentItem,
      this.props.contextId,
      this.props.toolConsumerInstanceGuid,
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

  renderLtiLaunchBuilder() {
    return (
      <li>
        <button onClick={() => this.generateLtiLaunch()}>
          LTI Launch with custom config
        </button>
      </li>
    );
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
          { this.renderLtiLaunchBuilder() }
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
              () => embedImage('Atomic Jolt Logo', 'Atomic Jolt Logo', '828px', '571px', `${this.props.apiUrl}atomicjolt.png`)
          ) }
        </ul>
      </div>
    );
  }

}

export default connect(select, { getContentItemSelection, createLtiLaunch })(Selector);
