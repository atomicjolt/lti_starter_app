import React from 'react';
import assets from '../libs/assets';
import Auth from '../../../libs/canvas/components/canvas_authentication';

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
