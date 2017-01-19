import React                  from 'react';
import { connect }            from 'react-redux';
import { getLtiApplications } from '../../../actions/lti_applications';
import Sidebar                from './sidebar';
import InstallPane         from './install_pane';

function select(state) {
  return {
    ltiApplications: state.ltiApplications,
  };
}

export class Home extends React.Component {
  static propTypes = {
    getAccounts: React.PropTypes.func.isRequired
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

        <header className="c-head">
          <div className="c-back">
            <button className="c-btn c-btn--back"><i className="i-back" />Back</button>
          </div>
          <img className="c-logo" src="img/logo.svg" alt="Atomic Jolt Logo" />
          <ul className="c-user">
            <li>
              <div className="c-username">Brandon Findlay <i className="i-dropdown" /></div>
            </li>
          </ul>
        </header>

        <div className="o-contain">
          <Sidebar accounts={this.props.accounts} />
          <InstallPane courses={this.props.courses} accounts={this.props.accounts} />
        </div>
      </div>
    );
  }
}

export default connect(select, { getLtiApplications })(Home);
