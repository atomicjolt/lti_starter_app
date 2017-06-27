import React from 'react';
import PropTypes from 'prop-types';

export default class Index extends React.Component {

  static propTypes = {
    children: PropTypes.node,
  };

  static defaultProps = {
    children: '',
  }

  constructor() {
    super();
    this.state = {};
  }

  render() {
    return (
      <div className="app-index">
        {this.props.children}
      </div>
    );
  }

}
