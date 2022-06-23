import _ from 'lodash';
import React, { useState } from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import SiteModal from '../sites/modal';
import ApplicationInstanceForm from './form';

export default function Modal(props) {
  const {
    isOpen,
    closeModal: closeCurrentModal,
    sites,
    save: saveApplicationInstance,
    applicationInstance,
    application,
  } = props;

  const [siteModalOpen, setSiteModalOpen] = useState(false);
  const [
    newApplicationInstance,
    setNewApplicationInstance
  ] = useState(applicationInstance || {});
  const [configParseError, setConfigParseError] = useState(null);
  const [ltiConfigParseError, setLtiConfigParseError] = useState(null);

  const newSite = () => {
    setSiteModalOpen(true);
  };

  const closeSiteModal = () => {
    setSiteModalOpen(false);
  };

  const closeModal = () => {
    closeSiteModal();
    closeCurrentModal();
  };

  const newApplicationInstanceChange = (e) => {
    setConfigParseError(null);
    if (e.target.name === 'config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        setConfigParseError(err.toString());
      }
    }

    setLtiConfigParseError(null);
    if (e.target.name === 'lti_config') {
      try {
        JSON.parse(e.target.value || '{}');
      } catch (err) {
        setLtiConfigParseError(err.toString());
      }
    }

    if (e.target.name === 'anonymous') {
      const tempNewApplicationInstance = _.cloneDeep(newApplicationInstance);
      tempNewApplicationInstance.anonymous = false;
      if (e.target.checked) {
        tempNewApplicationInstance.anonymous = true;
      }
      setNewApplicationInstance(tempNewApplicationInstance);
      return;
    }

    if (e.target.name === 'rollbar_enabled') {
      const tempNewApplicationInstance = _.cloneDeep(newApplicationInstance);
      tempNewApplicationInstance.rollbar_enabled = false;
      if (e.target.checked) {
        tempNewApplicationInstance.rollbar_enabled = true;
      }
      setNewApplicationInstance(tempNewApplicationInstance);
      return;
    }

    if (e.target.name === 'use_scoped_developer_key') {
      const tempNewApplicationInstance = _.cloneDeep(newApplicationInstance);
      tempNewApplicationInstance.use_scoped_developer_key = false;
      if (e.target.checked) {
        tempNewApplicationInstance.use_scoped_developer_key = true;
      }
      setNewApplicationInstance(tempNewApplicationInstance);
      return;
    }

    setNewApplicationInstance(
      {
        ...newApplicationInstance,
        [e.target.name]: e.target.value
      }
    );
    setConfigParseError(configParseError);
    setLtiConfigParseError(ltiConfigParseError);
  };

  const save = () => {
    saveApplicationInstance(
      application.id,
      newApplicationInstance
    );
    closeCurrentModal();
  };

  const applicationName = application ? application.name : 'Application';
  let title = 'New';
  let siteId;
  if (newApplicationInstance.site_id
      || (applicationInstance && applicationInstance.id)) {
    title = 'Update';
    siteId = newApplicationInstance.site_id || applicationInstance.site.id;
  }
  const isUpdate = !!(applicationInstance && applicationInstance.id);

  return (
    <ReactModal
      isOpen={isOpen}
      onRequestClose={() => closeModal()}
      contentLabel="Application Instances Modal"
      overlayClassName="c-modal__background"
      className="c-modal c-modal--settings is-open"
    >
      <h2 className="c-modal__title">
        {title}
        {' '}
        {applicationName}
        {' '}
        Instance
      </h2>
      <ApplicationInstanceForm
        config={newApplicationInstance.config}
        domain={newApplicationInstance.domain}
        lti_config={newApplicationInstance.lti_config}
        lti_key={newApplicationInstance.lti_key}
        lti_secret={newApplicationInstance.lti_secret}
        ltiConfigParseError={newApplicationInstance.ltiConfigParseError}
        canvas_token_preview={newApplicationInstance.canvas_token_preview}
        anonymous={newApplicationInstance.anonymous}
        rollbar_enabled={newApplicationInstance.rollbar_enabled}
        use_scoped_developer_key={newApplicationInstance.use_scoped_developer_key}
        nickname={newApplicationInstance.nickname}
        primary_contact={newApplicationInstance.primary_contact}
        configParseError={configParseError}
        onChange={(e) => { newApplicationInstanceChange(e); }}
        save={() => save()}
        sites={sites}
        site_id={`${siteId}`}
        closeModal={() => closeModal()}
        newSite={() => newSite()}
        isUpdate={isUpdate}
        applicationInstance={applicationInstance}
        languagesSupported={application.supported_languages || ['']}
      />
      <SiteModal
        isOpen={siteModalOpen}
        closeModal={() => closeSiteModal()}
      />
    </ReactModal>
  );

}

Modal.propTypes = {
  closeModal: PropTypes.func.isRequired,
  sites: PropTypes.shape({}),
  save: PropTypes.func.isRequired,
  applicationInstance: PropTypes.shape({
    id: PropTypes.number,
    config: PropTypes.string,
    site: PropTypes.shape({
      id: PropTypes.number,
    })
  }),
  application: PropTypes.shape({
    id: PropTypes.number,
    supported_languages: PropTypes.array,
  }),
};
