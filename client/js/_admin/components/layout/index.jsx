import React               from 'react';
import { connect }         from 'react-redux';
import { getApplications } from '../../actions/applications';

export class Index extends React.Component {

  static propTypes = {
    children: React.PropTypes.node,
    getApplications: React.PropTypes.func.isRequired,
  };

  static defaultProps = {
    children: '',
  }

  componentDidMount() {
    this.props.getApplications();
  }

  render() {
    return (
      <div className="app-index">
        {this.props.children}
      </div>
    );
  }

}

export default connect(null, { getApplications })(Index);
