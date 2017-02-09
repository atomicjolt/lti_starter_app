import React       from 'react';
import assets      from '../libs/assets';

import Auth    from './common/canvas_authentication';

const Home = function() {
  const img = assets('./images/atomicjolt.jpg');
  return (
    <div>
      <Auth />
      <img src={img} alt="Atomic Jolt Logo" />
    </div>
  );
};

export default Home;
