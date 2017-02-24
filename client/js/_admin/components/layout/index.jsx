import React               from 'react';
import { connect }         from 'react-redux';
import { getApplications } from '../../actions/applications';
import { getSites }        from '../../actions/sites';
import appHistory          from '../../history';

export class Index extends React.Component {

  static propTypes = {
    children: React.PropTypes.node,
    getSites: React.PropTypes.func.isRequired,
    getApplications: React.PropTypes.func.isRequired,
    location: React.PropTypes.shape({
      pathname: React.PropTypes.string,
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
        {this.props.children}
      </div>
    );
  }

}

export default connect(null, { getApplications, getSites })(Index);
