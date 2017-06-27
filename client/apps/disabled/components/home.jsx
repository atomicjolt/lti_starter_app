import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import assets from '../libs/assets';
import Auth from '../../../libs/canvas/components/canvas_authentication';
import Selector from './content_item_select/selector';

const select = state => ({
  canvasAuthRequired: state.settings.canvas_auth_required,
  ltiMessageType: state.settings.lti_message_type,
});

const Home = (props) => {

  const img = assets('./images/atomicjolt.jpg');

  if (props.ltiMessageType === 'ContentItemSelectionRequest') {
    return <Selector />;
  }

  return (
    <div>
      <img src={img} alt="Atomic Jolt Logo" />
      <h1>This account has been disabled</h1>
    </div>
  );

};

Home.propTypes = {
  canvasAuthRequired: PropTypes.bool,
  ltiMessageType: PropTypes.string,
};

export default connect(select)(Home);
