import React   from 'react';
import Heading from '../common/heading';

export default class Index extends React.Component {

  static propTypes = {
    children: React.PropTypes.node,
  };

  constructor() {
    super();
    this.state = {};
  }

  render() {
    return (
      <div>
        <Heading />
        {this.props.children}
      </div>
    );
  }

}
