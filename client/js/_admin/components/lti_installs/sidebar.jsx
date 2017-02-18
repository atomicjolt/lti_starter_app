import React from 'react';
import SubAccounts from './sub_accounts';
import Modal from '../application_instances/modal';

export default class Sidebar extends React.Component {
  static propTypes = {
    application: React.PropTypes.shape({
      name: React.PropTypes.string.isRequired,
    }),
    applicationInstance: React.PropTypes.shape({
      name: React.PropTypes.string
    }),
    accounts: React.PropTypes.shape({}),
    canvasRequest: React.PropTypes.func.isRequired,
    setAccountActive: React.PropTypes.func.isRequired,
    saveApplicationInstance: React.PropTypes.func.isRequired,
    activeAccounts: React.PropTypes.arrayOf(React.PropTypes.shape({})),
    sites: React.PropTypes.shape({}).isRequired,
  }

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  settings() {
    if (this.props.applicationInstance) {
      return (
        <span>
          <a onClick={() => this.setState({ modalOpen: true })}>
            <i className="i-settings" />
          </a>
          <Modal
            isOpen={this.state.modalOpen}
            closeModal={() => this.setState({ modalOpen: false })}
            sites={this.props.sites}
            save={this.props.saveApplicationInstance}
            application={this.props.application}
            applicationInstance={this.props.applicationInstance}
          />
        </span>
      );
    }
    return null;
  }

  render() {
    const schoolName = this.props.accounts[1] ? this.props.accounts[1].name : 'Loading...';
    const subAccounts = this.props.accounts[1] ? this.props.accounts[1].sub_accounts : [];
    const settings = this.settings();
    return (
      <div className="o-left">
        <div className="c-tool">
          {settings}
          <h4 className="c-tool__subtitle">LTI Tool</h4>
          <h3 className="c-tool__title">{this.props.application ? this.props.application.name : 'n/a'}</h3>
          <h4 className="c-tool__instance">{schoolName}</h4>
        </div>

        <div className="c-filters">
          <h4 className="c-accounts">Accounts</h4>
          <ul className="c-filter-list">
            <li className={'c-filter__item is-active'}>
              <button>
                <i className="i-dropdown" />
                {schoolName}
              </button>
              <SubAccounts
                // Need to only show if clicked.
                accounts={subAccounts}
                canvasRequest={this.props.canvasRequest}
                setAccountActive={this.props.setAccountActive}
                activeAccounts={this.props.activeAccounts}
              />
            </li>
          </ul>
        </div>
      </div>
    );
  }
}
