import React, { useState } from 'react';
import PropTypes from 'prop-types';
import ReactModal from 'react-modal';

import usePost from 'atomic-fuel/libs/hooks/use_post';

import Input from '../common/input';
import LtiInstallSelector from './lti_install_selector';


export default function LtiDeploymentModal(props) {
  const {
    isOpen,
    closeModal,
    applicationInstanceId,
    applicationId,
    setLastDeployment,
  } = props;

  const [ltiDeploymentId, setLtiDeploymentId] = useState('');
  const [ltiInstallId, setLtiInstallId] = useState();

  const {
    result, error, loading, postIt,
  } = usePost();

  function save() {
    const url = `api/application_instances/${applicationInstanceId}/lti_deployments`;
    postIt(url, {}, { deployment_id: ltiDeploymentId, lti_install_id: ltiInstallId });
  }

  let message = null;

  if (error) {
    message = error.message;
  } else if (loading) {
    message = 'Creating LTI Deployment...';
  } else if (result) {
    setLastDeployment();
    closeModal();
  }

  return (
    <ReactModal
      isOpen={isOpen}
      onRequestClose={() => closeModal()}
      contentLabel="Create LTI Deployment"
      overlayClassName="c-modal__background"
      className="c-modal c-modal--lti-deployment is-open"
    >
      <h2 className="c-modal__title">
        New LTI Deployment
      </h2>
      {message}
      <form>
        <div className="o-grid o-grid__modal-top">
          <div className="o-grid__item u-full">
            <Input
              className="c-input"
              labelText="Deployment ID"
              inputProps={{
                type: 'text',
                id: 'lti_deployment_id',
                value: ltiDeploymentId,
                onChange: (e) => setLtiDeploymentId(e.target.value),
              }}
            />
            <LtiInstallSelector
              applicationId={applicationId}
              ltiInstallId={ltiInstallId}
              setLtiInstallId={setLtiInstallId}
            />
          </div>
        </div>
        <button
          type="button"
          className="c-btn c-btn--yellow"
          onClick={save}
        >
          Save
        </button>
        <button
          type="button"
          className="c-btn c-btn--gray--large u-m-right"
          onClick={closeModal}
        >
          Cancel
        </button>
      </form>

    </ReactModal>
  );
}

LtiDeploymentModal.propTypes = {
  isOpen: PropTypes.bool,
  closeModal: PropTypes.func,
  applicationInstanceId: PropTypes.oneOfType([
    PropTypes.number,
    PropTypes.string,
  ]).isRequired,
  applicationId: PropTypes.oneOfType([
    PropTypes.number,
    PropTypes.string,
  ]).isRequired,
  setLastDeployment: PropTypes.func.isRequired,
};
