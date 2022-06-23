import React, { useState } from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import LtiInstallKeyForm from './form';

export default function Modal(props) {
  const {
    isOpen,
    closeModal,
    save,
    application,
    ltiInstallKey,
  } = props;
  const [newLtiInstallKey, setNewLtiInstallKey] = useState(ltiInstallKey || {});

  let title = 'New';
  if (ltiInstallKey && ltiInstallKey.id) {
    title = 'Update';
  }

  return (
    <ReactModal
      isOpen={isOpen}
      onRequestClose={closeModal}
      contentLabel="Lti Install Key Modal"
      overlayClassName="c-modal__background"
      className="c-modal c-modal--settings is-open"
    >
      <h2 className="c-modal__title">
        {title}
        {' '}
        Lti Install Key
      </h2>
      <LtiInstallKeyForm
        {...newLtiInstallKey}
        onChange={(e) => setNewLtiInstallKey({
          ...newLtiInstallKey,
          [e.target.name]: e.target.value
        })}
        save={() => {
          save(application.id, newLtiInstallKey);
          closeModal();
        }}
        closeModal={closeModal}
      />
    </ReactModal>
  );
}

Modal.propTypes = {
  closeModal: PropTypes.func.isRequired,
  save: PropTypes.func.isRequired,
  ltiInstallKey: PropTypes.shape({
    id: PropTypes.number,
    iss: PropTypes.string,
    clientId: PropTypes.string,
    jwksUrl: PropTypes.string,
    tokenUrl: PropTypes.string,
    oidcUrl: PropTypes.string,
  }),
  application: PropTypes.shape({
    id: PropTypes.number,
  }),
};
