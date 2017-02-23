import React from 'react';
import Accounts from './accounts';
import Modal from '../application_instances/modal';

export default class Sidebar extends React.Component {
  static propTypes = {
    application: React.PropTypes.shape({
      name: React.PropTypes.string.isRequired,
    }),
    applicationInstance: React.PropTypes.shape({
      name: React.PropTypes.string,
      site: React.PropTypes.shape({
        url: React.PropTypes.string
      })
    }),
    accounts: React.PropTypes.shape({}),
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
    const schoolUrl = this.props.applicationInstance ? this.props.applicationInstance.site.url : '';
    const settings = this.settings();
    return (
      <div className="o-left">
        <div className="c-tool">
          {settings}
          <h4 className="c-tool__subtitle">LTI Tool</h4>
          <h3 className="c-tool__title">{this.props.application ? this.props.application.name : 'n/a'}</h3>
        </div>

        <div className="c-tool">
          <h4 className="c-tool__instance"><a href={schoolUrl}>{schoolUrl}</a></h4>
        </div>

        <div className="c-filters">
          <h4 className="c-accounts">Accounts</h4>
          <Accounts
            accounts={this.props.accounts}
            setAccountActive={this.props.setAccountActive}
            activeAccounts={this.props.activeAccounts}
          />
        </div>
      </div>
    );
  }
}
