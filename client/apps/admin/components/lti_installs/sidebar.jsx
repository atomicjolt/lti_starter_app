import React from 'react';
import PropTypes from 'prop-types';
import Accounts from './accounts';
import Modal from '../application_instances/modal';

export default class Sidebar extends React.Component {
  static propTypes = {
    application: PropTypes.shape({
      name: PropTypes.string.isRequired,
    }),
    applicationInstance: PropTypes.shape({
      name: PropTypes.string,
      site: PropTypes.shape({
        url: PropTypes.string
      })
    }),
    accounts: PropTypes.shape({}),
    currentAccount: PropTypes.shape({}),
    setAccountActive: PropTypes.func.isRequired,
    saveApplicationInstance: PropTypes.func.isRequired,
    sites: PropTypes.shape({}).isRequired,
  }

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  get applicationInstanceModal() {
    if (this.state.modalOpen) {
      return <Modal
        closeModal={() => this.setState({ modalOpen: false })}
        sites={this.props.sites}
        save={this.props.saveApplicationInstance}
        application={this.props.application}
        applicationInstance={this.props.applicationInstance}
      />;
    }
    return null;
  }

  settings() {
    if (this.props.applicationInstance) {
      return (
        <span>
          <a onClick={() => this.setState({ modalOpen: true })}>
            <i className="i-settings" />
          </a>
          { this.applicationInstanceModal }
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
          <h4 className="c-sidebar-subtitle">Accounts</h4>
          <Accounts
            currentAccount={this.props.currentAccount}
            accounts={this.props.accounts}
            setAccountActive={this.props.setAccountActive}
          />
        </div>
      </div>
    );
  }
}
