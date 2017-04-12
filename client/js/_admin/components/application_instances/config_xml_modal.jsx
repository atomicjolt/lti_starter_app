import React from 'react';
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
            disabled: true,
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
            disabled: true,
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
            disabled: true,
            value: props.applicationInstance.lti_config_xml || '',
          }}
        />
      </div>
    </ReactModal>
  );
};

ConfigXmlModal.propTypes = {
  isOpen: React.PropTypes.bool.isRequired,
  closeModal: React.PropTypes.func.isRequired,
  application: React.PropTypes.shape({
    id: React.PropTypes.number,
    name: React.PropTypes.string,
  }),
  applicationInstance: React.PropTypes.shape({
    id: React.PropTypes.number,
    lti_config_xml: React.PropTypes.string,
    lti_key: React.PropTypes.string,
    lti_secret: React.PropTypes.string,
  }),
};

export default ConfigXmlModal;
