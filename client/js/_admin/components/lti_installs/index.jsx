import React               from 'react';
import { connect }         from 'react-redux';
import { hashHistory }     from 'react-router';
import _                   from 'lodash';
import { getapplications } from '../../actions/applications';
import { getCanvasAccounts } from '../../actions/accounts';
import Header              from '../common/heading';
import Sidebar             from './sidebar';
import InstallPane         from './install_pane';

function select(state) {
  return {
    applications: state.applications,
    accounts: state.accounts,
    userName: state.settings.display_name,
  };
}

export class Home extends React.Component {
  static propTypes = {
    accounts: React.PropTypes.shape({}).isRequired,
    applications: React.PropTypes.shape({}).isRequired,
    courses: React.PropTypes.shape({}).isRequired,
    userName: React.PropTypes.string.isRequired,
    getCanvasAccounts: React.PropTypes.func.isRequired,
  };

  componentDidMount() {
    this.props.getCanvasAccounts();
  }

  // <!-- <ul className="c-dropdown">
  // <li>
  // <a href="">
  // <span className="c-menu-item">Logout</span>
  // </a>
  // </li>
  //  </ul> -->

  render() {
    if (_.isEmpty(this.props.accounts)) { return null; }
    return (
      <div style={{ height: '100%' }}>
        <Header
          back={() => hashHistory.goBack()}
          userName={this.props.userName}
        />
        <div className="o-contain">
          <Sidebar accounts={this.props.accounts} application={this.props.applications[2]} />
          <InstallPane courses={this.props.courses} accounts={this.props.accounts} />
        </div>
      </div>
    );
  }
}

export default connect(select, { getapplications, getCanvasAccounts })(Home);
