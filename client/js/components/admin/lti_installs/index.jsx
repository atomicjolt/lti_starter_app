import React                  from 'react';
import { connect }            from 'react-redux';
import { hashHistory }        from 'react-router';
import { getLtiApplications } from '../../../actions/applications';
import Header                 from '../common/heading';
import Sidebar                from './sidebar';
import InstallPane            from './install_pane';

function select(state) {
  return {
    ltiApplications: state.ltiApplications,
    userName: state.settings.display_name,
  };
}

export class Home extends React.Component {
  static propTypes = {
    accounts: React.PropTypes.shape({}).isRequired,
    courses: React.PropTypes.shape({}).isRequired,
    userName: React.PropTypes.string,
  };

  componentDidMount() {
    // this.props.getAccounts(1);
  }

  // <!-- <ul className="c-dropdown">
  // <li>
  // <a href="">
  // <span className="c-menu-item">Logout</span>
  // </a>
  // </li>
  //  </ul> -->

  render() {
    return (
      <div style={{ height: '100%' }}>
        <Header
          back={() => hashHistory.goBack()}
          userName={this.props.userName}
        />
        <div className="o-contain">
          <Sidebar accounts={this.props.accounts} />
          <InstallPane courses={this.props.courses} accounts={this.props.accounts} />
        </div>
      </div>
    );
  }
}

export default connect(select, { getLtiApplications })(Home);
