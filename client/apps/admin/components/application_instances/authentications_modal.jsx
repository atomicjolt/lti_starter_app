import _ from 'lodash';
import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';

import { checkApplicationInstanceAuth } from '../../actions/application_instances';

const select = state => ({
  authenticationChecks: state.authenticationChecks
});

export class AuthenticationsModal extends React.Component {
  static propTypes = {
    isOpen: PropTypes.bool.isRequired,
    closeModal: PropTypes.func.isRequired,
    authentications: PropTypes.array,
    checkApplicationInstanceAuth: PropTypes.func.isRequired,
    applicationInstance: PropTypes.shape({
      id: PropTypes.number,
      config: PropTypes.string,
      site: PropTypes.shape({
        id: PropTypes.number,
      })
    }),
    application: PropTypes.shape({
      id: PropTypes.number,
    }),
    authenticationChecks: PropTypes.shape({}),
  };

  showInstanceModal() {
    if (this.props.isOpen) {
      return 'is-open';
    }
    return '';
  }

  closeModal() {
    this.props.closeModal();
  }

  checkAuth(authentication) {
    this.props.checkApplicationInstanceAuth(
      this.props.application.id,
      this.props.applicationInstance.id,
      authentication.id,
    );
  }

  renderAccounts(authenticationId) {
    const accounts = this.props.authenticationChecks[authenticationId];
    return _.map(accounts, account => (
      <tr key={`auth_${authenticationId}_${account.id}`}>
        <td />
        <td>Can Access:</td>
        <td>{account.name}</td>
        <td>Id: {account.id}</td>
        <td>ParentId: {account.parent_account_id}</td>
        <td>RootId: {account.root_account_id}</td>
      </tr>
    ));
  }

  renderRows() {
    return _.map(this.props.authentications, authentication => (
      <tbody key={`auth_${authentication.id}`}>
        <tr>
          <td>{authentication.id}</td>
          <td>{authentication.user}</td>
          <td>{authentication.email}</td>
          <td>{authentication.provider}</td>
          <td>{authentication.created_at}</td>
          <td>
            <button
              className="c-btn c-btn--gray"
              onClick={() => this.checkAuth(authentication)}
            >
              Check
            </button>
          </td>
        </tr>
        {this.renderAccounts(authentication.id)}
      </tbody>
    ));
  }

  render() {
    const title = 'Authentications';

    return (
      <ReactModal
        isOpen={this.props.isOpen}
        onRequestClose={() => this.closeModal()}
        contentLabel="Application Instances Modal"
        overlayClassName="c-modal__background"
        className={`c-modal c-modal--settings ${this.showInstanceModal()}`}
      >
        <div className="o-grid o-grid__modal-top">
          <h2 className="c-modal__title">
            {title}
          </h2>
          <table className="c-table c-table--instances">
            <thead>
              <tr>
                <th><span>id</span></th>
                <th><span>User</span></th>
                <th><span>Email</span></th>
                <th><span>Provider</span></th>
                <th><span>CREATED</span></th>
                <th />
              </tr>
            </thead>
            { this.renderRows() }
          </table>
        </div>
        <button
          type="button"
          className="c-btn c-btn--gray--large u-m-right"
          onClick={() => this.props.closeModal()}
        >
          Close
        </button>
      </ReactModal>
    );
  }
}

export default connect(select, { checkApplicationInstanceAuth })(AuthenticationsModal);

