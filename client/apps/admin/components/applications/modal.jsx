import React, { useState } from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import Form from './form';

export default function Modal(props) {
  const {
    application: applicationProp,
    isOpen,
    closeModal,
    save,
  } = props;

  const [application, setApplication] = useState(applicationProp);
  const [configParseError, setConfigParseError] = useState(null);

  const applicationChange = (e) => {
    let newConfigParseError = null;
    if (e.target.name === 'default_config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        newConfigParseError = err.toString();
      }
    }

    setApplication({
      ...application,
      [e.target.name]: e.target.value,
    });

    setConfigParseError(newConfigParseError);
  };

  const saveApplication = () => {
    save(application);
  };

  return (
    <ReactModal
      isOpen={isOpen}
      onRequestClose={() => closeModal()}
      save={saveApplication}
      contentLabel="Modal"
      overlayClassName="c-modal__background"
      className="c-modal c-modal--settings is-open"
    >
      <h2 className="c-modal__title">
        {application.name}
        {' '}
        Settings
      </h2>
      <Form
        description={application.description}
        oauthKey={application.oauth_key}
        oauthSecret={application.oauth_secret}
        canvasApiPermissions={application.canvas_api_permissions}
        defaultConfig={application.default_config}
        configParseError={configParseError}
        onChange={(e) => { applicationChange(e); }}
        closeModal={() => closeModal()}
        save={() => saveApplication()}
      />
    </ReactModal>
  );
}

Modal.propTypes = {
  application: PropTypes.shape({
    name: PropTypes.string,
    description: PropTypes.string,
    default_config: PropTypes.string,
    canvas_api_permissions: PropTypes.object,
    oauth_key: PropTypes.string,
    oauth_secret: PropTypes.string,
  }),
  isOpen: PropTypes.bool.isRequired,
  closeModal: PropTypes.func.isRequired,
  save: PropTypes.func,
};
