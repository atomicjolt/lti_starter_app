import * as React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import Auth from 'atomic-canvas/libs/components/canvas_authentication';

import assets from '../libs/assets';
import Selector from './content_item_select/selector';

const select = state => ({
  canvasAuthRequired: state.settings.canvas_auth_required,
  ltiMessageType: state.settings.lti_message_type,
});

export class Home extends React.Component {

  static propTypes = {
    canvasAuthRequired: PropTypes.bool,
    ltiMessageType: PropTypes.string,
  };

  render() {
    const img = assets('./images/atomicjolt.jpg');

    if (this.props.ltiMessageType === 'ContentItemSelectionRequest') {
      return <Selector />;
    }

    return (
      <div>
        <img src={img} alt="Atomic Jolt Logo" />
        <hr />
        <Auth />
        <hr />
        { this.props.canvasAuthRequired ? <Auth /> : null }
      </div>
    );
  }

}

export default connect(select)(Home);
