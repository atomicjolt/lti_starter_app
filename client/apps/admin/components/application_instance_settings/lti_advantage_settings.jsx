import React, { useEffect, useState } from 'react';
import PropTypes from 'prop-types';

import useGet from 'atomic-fuel/libs/hooks/use_get';
import useDelete from 'atomic-fuel/libs/hooks/use_delete';
import Loader from '../../../../common/components/common/atomicjolt_loader';

import LtiDeploymentModal from './lti_deployment_modal';

function Title({ ltiDeployments }) {
  let count;
  if (ltiDeployments) {
    count = ltiDeployments.length;
  }
  return (
    <div className="aj-col-flex">
      {count}
      {' '}
      LTI Deployments
    </div>
  );
}

function Error({ error }) {
  if (error) {
    return (
      <div>{error.message}</div>
    );
  }
  return null;
}

function LtiDeployments({ ltiDeployments, setLastDeployment, applicationInstanceId }) {
  if (ltiDeployments) {
    return (
      <table>
        <thead>
          <tr>
            <th>Deployment Id</th>
            <th>LTI Install Id</th>
            <th>Created</th>
            <th>Last Updated</th>
            <th />
          </tr>
        </thead>
        <tbody>
          {
            ltiDeployments.map((l) => <LtiDeployment
              key={l.id}
              ltiDeployment={l}
              setLastDeployment={setLastDeployment}
              applicationInstanceId={applicationInstanceId}
            />)
          }
        </tbody>
      </table>
    );
  }
  return null;
}

function LtiDeployment({ ltiDeployment, setLastDeployment, applicationInstanceId }) {
  const {
    result,
    error,
    loading,
    deleteIt,
  } = useDelete();

  let content = (
    <button
      type="button"
      className="aj-btn"
      onClick={() => {
        const url = `api/application_instances/${applicationInstanceId}/lti_deployments/${ltiDeployment.id}`;
        deleteIt(url);
      }}
    >
      Delete
    </button>
  );

  if (error) {
    content = `Error deleting LTI Deployment. Status: ${error.status}`;
  } else if (loading) {
    content = 'Deleting...';
  } else if (result) {
    setLastDeployment(ltiDeployment.id);
    return null;
  }

  return (
    <tr key={ltiDeployment.id}>
      <td>{ltiDeployment.deployment_id}</td>
      <td>{ltiDeployment.lti_install_id}</td>
      <td>{ltiDeployment.created_at}</td>
      <td>{ltiDeployment.updated_at}</td>
      <td>
        {content}
      </td>
    </tr>
  );
}

export default function LtiAdvantageSettings(props) {
  const {
    params,
  } = props;
  const { applicationInstanceId, applicationId } = params;
  const [showNewLtiDeployment, setShowNewLtiDeployment] = useState(false);
  // This is used to trigger a refresh of the displayed lti deployments
  const [lastDeployment, setLastDeployment] = useState();
  const {
    result, error, loading, getIt,
  } = useGet();
  const payload = result ? result.body : {};
  const {
    lti_deployment_keys: ltiDeployments,
  } = payload;

  useEffect(() => {
    const url = `api/application_instances/${applicationInstanceId}/lti_deployments`;
    getIt(url);
  }, [params.applicationInstanceId, lastDeployment]);

  return (
    <div className="aj-columns">
      <div className="aj-col-flex">
        <div className="aj-settings-title">
          <Title ltiDeployments={ltiDeployments} />
          <div className="flex-center">
            <button type="button" className="aj-btn" onClick={() => setShowNewLtiDeployment(true)}>
              New LTI Deployment
            </button>
          </div>
        </div>
        <Error error={error} />
        {
          loading
            ? <Loader />
            : <LtiDeployments ltiDeployments={ltiDeployments} setLastDeployment={setLastDeployment} applicationInstanceId={applicationInstanceId} />
        }
      </div>
      <LtiDeploymentModal
        isOpen={showNewLtiDeployment}
        closeModal={() => setShowNewLtiDeployment(false)}
        applicationInstanceId={applicationInstanceId}
        applicationId={applicationId}
        setLastDeployment={setLastDeployment}
      />
    </div>
  );
}

LtiAdvantageSettings.propTypes = {
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
};
