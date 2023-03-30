import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { useSelector } from 'react-redux';
import _ from 'lodash';

import useGet from 'atomic-fuel/libs/hooks/use_get';

import PlatformGuidStrategies from '../atomic_admin/platform_guid_strategies/inline_index';
import ClientIdStrategies from '../atomic_admin/client_id_strategies/inline_index';
import Deployments from '../atomic_admin/deployments/inline_index';

function Error({ error }) {
  if (error) {
    return (
      <div>{error.message}</div>
    );
  }
  return null;
}

export default function LtiAdvantageSettings(props) {
  const {
    params,
  } = props;
  const { applicationInstanceId, applicationId } = params;
  const { error, getIt } = useGet();
  const applicationInstances = useSelector(
    (state) => _.filter(state.applicationInstances?.applicationInstances || [],
      { application_id: parseInt(applicationId, 10) }),
  );

  useEffect(() => {
    const url = `api/application_instances/${applicationInstanceId}/lti_deployments`;
    getIt(url);
  }, [params.applicationInstanceId]);

  const applicationInstance = applicationInstances && _.filter(applicationInstances, (app) => (
    app.id === _.parseInt(applicationInstanceId)
  ))[0];

  return (
    <div>
      <div className="aj-columns">
        <div className="aj-col-flex">
          <Error error={error} />
        </div>
      </div>
      <div className="c-info">
        <div className="c-title">
          <h1>Installation Information </h1>
          <label htmlFor="lti_config_url" className="c-input aj-input--border" disabled>
            <span>Lti Config Url (For Canvas Only)</span>
            <input id="lti_config_url" name="lti_config_url" type="text" value={applicationInstance?.canvas_lti_advantage_config_url} disabled />
          </label>
        </div>
      </div>
      <ClientIdStrategies params={params} />
      <PlatformGuidStrategies params={params} />
      <Deployments params={params} />
    </div>
  );
}

LtiAdvantageSettings.propTypes = {
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
};
