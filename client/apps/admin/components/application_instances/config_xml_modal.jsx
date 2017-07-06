import React from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';
import Textarea from '../common/textarea';
import Input from '../common/input';

const ConfigXmlModal = (props) => {
  const application = props.application;
  const applicationName = application ? application.name : 'Application';

  return (
    <ReactModal
      isOpen={props.isOpen}
      onRequestClose={() => props.closeModal()}
      contentLabel="Application Instances Modal"
      overlayClassName="c-modal__background"
      className="c-modal c-modal--settings is-open"
    >
      <h2 className="c-modal__title">
        Config XML for {applicationName} Instance
      </h2>
      <div className="o-grid__item u-half">
        <Input
          className="c-input"
          labelText="LTI Key"
          inputProps={{
            id: 'lti_config_xml_lti_key',
            name: 'lti_key',
            type: 'text',
            readonly: true,
            value: props.applicationInstance.lti_key,
          }}
        />
      </div>
      <div className="o-grid__item u-half">
        <Input
          className="c-input"
          labelText="LTI Secret"
          inputProps={{
            id: 'lti_config_xml_lti_secret',
            name: 'lti_secret',
            type: 'text',
            readonly: true,
            value: props.applicationInstance.lti_secret,
          }}
        />
      </div>
      <div className="o-grid__item u-full">
        <Textarea
          className="c-input"
          labelText="LTI Config XML"
          textareaProps={{
            id: 'application_instance_lti_config_xml',
            name: 'lti_config_xml',
            rows: 20,
            readonly: true,
            value: props.applicationInstance.lti_config_xml || '',
          }}
        />
      </div>
      <button
        type="button"
        className="c-btn c-btn--gray--large u-m-right"
        onClick={() => props.closeModal()}
      >
        Close
      </button>
    </ReactModal>
  );
};

ConfigXmlModal.propTypes = {
  isOpen: PropTypes.bool.isRequired,
  closeModal: PropTypes.func.isRequired,
  application: PropTypes.shape({
    id: PropTypes.number,
    name: PropTypes.string,
  }),
  applicationInstance: PropTypes.shape({
    id: PropTypes.number,
    lti_config_xml: PropTypes.string,
    lti_key: PropTypes.string,
    lti_secret: PropTypes.string,
  }),
};

export default ConfigXmlModal;
