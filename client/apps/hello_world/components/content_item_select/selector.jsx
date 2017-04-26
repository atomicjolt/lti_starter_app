import _ from 'lodash';
import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';

import ContentItemSelectionForm from '../../../../libs/canvas/components/content_item_selection_form';
import assets from '../../libs/assets';
import { getContentItemSelection } from '../../actions/content_items';

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

  selectItem() {
    if (false && _.includes(this.props.acceptMediaTypes, 'text/html')) {
      this.props.getContentItemSelection(
        this.props.contentItemReturnURL,
        'html',
        null,
        '<h1>Atomic Jolt</h1>',
        null
      );
    } else {
      this.props.getContentItemSelection(
        this.props.contentItemReturnURL,
        'lti_link',
        `${this.props.apiUrl}lti_launches`,
        null,
        'Atomic Jolt LTI Launch'
      );
    }
  }

  render() {

    if (!_.isEmpty(this.props.contentItemSelection)) {
      return (
        <ContentItemSelectionForm
          launchData={this.props.contentItemSelection}
          contentItemReturnURL={this.props.contentItemReturnURL}
        />
      );
    }

    const img = assets('./images/atomicjolt.jpg');

    return (
      <div>
        <h2>Select An Item:</h2>
        <ul>
          <li>
            <button onClick={e => this.selectItem()}>
              <img src={img} alt="Atomic Jolt Logo" />
            </button>
          </li>
        </ul>
      </div>
    );
  }

}

export default connect(select, { getContentItemSelection })(Selector);
