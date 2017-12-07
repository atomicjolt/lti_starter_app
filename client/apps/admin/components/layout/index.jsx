import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { getApplications } from '../../actions/applications';
import { getSites } from '../../actions/sites';
import appHistory from '../../history';
import Errors from './errors';

export class Index extends React.Component {

  static propTypes = {
    children: PropTypes.node,
    getSites: PropTypes.func.isRequired,
    getApplications: PropTypes.func.isRequired,
    location: PropTypes.shape({
      pathname: PropTypes.string,
    }),
  };

  static defaultProps = {
    children: '',
  }

  componentDidMount() {
    this.props.getApplications();
    this.props.getSites();
    if (this.props.location.pathname === '/') {
      appHistory.replace('/applications');
    }
  }

  render() {
    return (
      <div className="app-index">
        <Errors />
        {this.props.children}
      </div>
    );
  }

}

export default connect(null, { getApplications, getSites })(Index);
