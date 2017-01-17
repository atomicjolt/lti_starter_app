import React       from 'react';
import { connect } from 'react-redux';
import assets      from '../libs/assets';

export default class Home extends React.Component {

  render() {
    const img = assets('./images/atomicjolt.jpg');
    return (
      <div>
        <img src={img} alt="Atomic Jolt Logo" />
      </div>
    );
  }
}
