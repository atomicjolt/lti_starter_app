import React, { useState } from 'react';
import PropTypes from 'prop-types';
import Modal from './modal';
import DeleteModal from '../common/delete_modal';

export default function ListRow(props) {
  const {
    delete: delLtiInstallKey,
    save,
    application,
    ltiInstallKey,
  } = props;

  const [modalOpen, setModalOpen] = useState(false);
  const [confirmDeleteModalOpen, setConfirmDeleteModalOpen] = useState(false);

  const getStyles = () => ({
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
  });

  const ltiInstallKeyModal = () => {

    if (modalOpen) {

      return <Modal
        isOpen={modalOpen}
        closeModal={() => setModalOpen(false)}
        save={save}
        application={application}
        ltiInstallKey={ltiInstallKey}
      />;
    }
    return null;
  };

  const closeDeleteModal = () => {
    setConfirmDeleteModalOpen(false);
  };

  const deleteLtiInstallKey = (appId, ltiInstallKeyId) => {
    setConfirmDeleteModalOpen(false);
    delLtiInstallKey(appId, ltiInstallKeyId);
  };

  const styles = getStyles();
  const createdAt = new Date(ltiInstallKey.created_at);

  return (
    <tr>
      <td>
        <button
          type="button"
          style={styles.buttonIcon}
          onClick={() => setModalOpen(true)}
        >
          <i className="material-icons">settings</i>
        </button>
        { ltiInstallKeyModal() }
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
          type="button"
          className="c-delete"
          style={styles.buttonIcon}
          onClick={() => setConfirmDeleteModalOpen(true)}
        >
          <i className="i-delete" />
        </button>
        <DeleteModal
          isOpen={confirmDeleteModalOpen}
          closeModal={() => closeDeleteModal()}
          deleteRecord={
            () => deleteLtiInstallKey(
              ltiInstallKey.application_id,
              ltiInstallKey.id,
            )
          }
        />
      </td>
    </tr>
  );

}

ListRow.propTypes = {
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
