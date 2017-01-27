import React                 from 'react';
import { connect }           from 'react-redux';
import _                     from 'lodash';
import history               from '../../history';
import { getapplications }   from '../../actions/applications';
import { getCanvasAccounts } from '../../actions/accounts';
import canvasRequest         from '../../../libs/canvas/action';
import Heading               from '../common/heading';
import Sidebar               from './sidebar';
import InstallPane           from './install_pane';

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
        <Heading back={() => history.goBack()} />
        <div className="o-contain">
          <Sidebar
            accounts={this.props.accounts}
            application={this.props.applications[2]}
            canvasRequest={this.props.canvasRequest}
          />
          <InstallPane courses={this.props.courses} accounts={this.props.accounts} />
        </div>
      </div>
    );
  }
}

export default connect(select, { getapplications, getCanvasAccounts, canvasRequest })(Home);
