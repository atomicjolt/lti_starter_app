// @flow

import * as React from 'react';
import { connect } from 'react-redux';
import assets from '../libs/assets';
import Auth from '../../../libs/canvas/components/canvas_authentication';
import Selector from './content_item_select/selector';

const select = state => ({
  canvasAuthRequired: state.settings.canvas_auth_required,
  ltiMessageType: state.settings.lti_message_type,
});

type Props = {
  canvasAuthRequired: boolean,
  ltiMessageType: string,
};

function Home(props :Props) :React.Node {
  const img = assets('./images/atomicjolt.jpg');

  if (props.ltiMessageType === 'ContentItemSelectionRequest') {
    return <Selector />;
  }

  return (
    <div>
      <img src={img} alt="Atomic Jolt Logo" />
      <hr />
      <Auth />
      <hr />
      { props.canvasAuthRequired ? <Auth /> : null }
    </div>
  );

}

export default connect(select)(Home);
