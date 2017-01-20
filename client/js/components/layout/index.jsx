import React   from 'react';
import Heading from '../admin/common/heading';

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
      <div className="app-index">
        <Heading />
        {this.props.children}
      </div>
    );
  }

}
