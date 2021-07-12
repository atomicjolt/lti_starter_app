import React from 'react';
import PropTypes from 'prop-types';

import Modal from './modal';
import DeleteModal from '../common/delete_modal';

export default class ListRow extends React.Component {
  static propTypes = {
    delete: PropTypes.func.isRequired,
    save: PropTypes.func.isRequired,
    application: PropTypes.shape({}),
    ltiInstallKey: PropTypes.shape({
      id: PropTypes.number.isRequired,
      application_id: PropTypes.number.isRequired,
      iss: PropTypes.string.isRequired,
      clientId: PropTypes.string.isRequired,
      jwksUrl: PropTypes.string.isRequired,
      tokenUrl: PropTypes.string.isRequired,
      oidcUrl: PropTypes.string.isRequired,
      created_at: PropTypes.string.isRequired,
    }).isRequired,
  };

  static getStyles() {
    return {
      buttonIcon: {
        border: 'none',
        backgroundColor: 'transparent',
        color: 'grey',
        fontSize: '1.5em',
        cursor: 'pointer',
      },
      buttonNumber: {
        height: '3rem',
        borderRadius: '3px',
        background: '#f5f5f5',
        border: 'none',
        color: 'grey',
        fontSize: '1.5em',
        cursor: 'pointer',
      },
    };
  }

  constructor() {
    super();
    this.state = {
      modalOpen: false,
      confirmDeleteModalOpen: false,
    };
  }

  get ltiInstallKeyModal() {
    const {
      modalOpen,
    } = this.state;

    if (modalOpen) {
      const {
        save,
        application,
        ltiInstallKey,
      } = this.props;

      return <Modal
        closeModal={() => this.setState({ modalOpen: false })}
        save={save}
        application={application}
        ltiInstallKey={ltiInstallKey}
      />;
    }
    return null;
  }

  closeDeleteModal() {
    this.setState({
      confirmDeleteModalOpen: false,
    });
  }

  deleteLtiInstallKey(appId, ltiInstallKeyId) {
    this.setState({
      confirmDeleteModalOpen: false,
    });
    this.props.delete(appId, ltiInstallKeyId);
  }

  render() {
    const { ltiInstallKey } = this.props;
    const styles = ListRow.getStyles();
    const createdAt = new Date(ltiInstallKey.created_at);

    return (
      <tr>
        <td>
          <button
            style={styles.buttonIcon}
            onClick={() => this.setState({ modalOpen: true })}
          >
            <i className="material-icons">settings</i>
          </button>
          { this.ltiInstallKeyModal }
        </td>
        <td>
          {ltiInstallKey.id}
        </td>
        <td>
          {ltiInstallKey.iss}
        </td>
        <td>
          {ltiInstallKey.clientId}
        </td>
        <td>
          {createdAt.toLocaleDateString()}
          {' '}
          {createdAt.toLocaleTimeString()}
        </td>
        <td>
          <button
            className="c-delete"
            style={styles.buttonIcon}
            onClick={() => this.setState({ confirmDeleteModalOpen: true })}
          >
            <i className="i-delete" />
          </button>
          <DeleteModal
            isOpen={this.state.confirmDeleteModalOpen}
            closeModal={() => this.closeDeleteModal()}
            deleteRecord={
              () => this.deleteLtiInstallKey(
                ltiInstallKey.application_id,
                ltiInstallKey.id,
              )
            }
          />
        </td>
      </tr>
    );
  }
}
