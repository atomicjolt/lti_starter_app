import React       from 'react';
import assets      from '../libs/assets';

import Auth    from './common/canvas_authentication';

export default class Home extends React.Component {

  render() {
    const img = assets('./images/atomicjolt.jpg');
    return (
      <div>
        <Auth />
        <img src={img} alt="Atomic Jolt Logo" />
      </div>
    );
  }
}
