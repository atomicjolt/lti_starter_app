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
  contentItems,
  embedHtml,
  ltiLaunch,
  embedIframe,
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

  selectItem(type) {

    let contentItem = {};

    switch (type) {
      case 'html':
        contentItem = embedHtml('<h1>Atomic Jolt</h1>');
        break;
      case 'iframe':
        contentItem = embedIframe(`${this.props.apiUrl}lti_launches`);
        break;
      case 'link':
        contentItem = ltiLaunch('Atomic Jolt LTI Launch', `${this.props.apiUrl}lti_launches`);
        break;
      case 'image':
        contentItem = embedHtml(`${this.props.apiUrl}atomicjolt.png`);
        break;
      default:
        throw new Error(`Invalid type: ${type}`);
    }

    this.props.getContentItemSelection(
      this.props.contentItemReturnURL,
      contentItems(contentItem)
    );
  }

  renderHtmlSelect() {
    if (_.includes(this.props.acceptMediaTypes, 'text/html')) {
      return (
        <li>
          <button onClick={() => this.selectItem('html')}>
            Add Html
          </button>
        </li>
      );
    }
    return null;
  }

  renderIframeSelect() {
    if (_.includes(this.props.acceptMediaTypes, 'text/html')) {
      return (
        <li>
          <button onClick={() => this.selectItem('iframe')}>
            Add iFrame
          </button>
        </li>
      );
    }
    return null;
  }

  renderLtiLinkSelect() {
    if (_.includes(this.props.acceptMediaTypes, 'application/vnd.ims.lti.v1.ltilink')) {
      return (
        <li>
          <button onClick={() => this.selectItem('lti_link')}>
            Add Link
          </button>
        </li>
      );
    }
    return null;
  }

  renderImageSelect() {
    if (_.includes(this.props.acceptMediaTypes, 'image/*')) {
      return (
        <li>
          <button onClick={() => this.selectItem('image')}>
            Add Image
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
          { this.renderHtmlSelect() }
          { this.renderIframeSelect() }
          { this.renderLtiLinkSelect() }
          { this.renderImageSelect() }
        </ul>
      </div>
    );
  }

}

export default connect(select, { getContentItemSelection })(Selector);
