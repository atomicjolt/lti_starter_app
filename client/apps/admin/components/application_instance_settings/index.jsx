import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import Heading from '../common/heading';
import Header from './header';
import ApplicationInstanceSettings from './application_instance_settings';
import Loader from '../../../../common/components/common/atomicjolt_loader';
import * as ApplicationInstanceActions from '../../actions/application_instances';

export default function Index(props) {

  const {
    router,
    params,
    deleteApplicationInstance,
    disableApplicationInstance,
    children,
    location,
  } = props;

  const dispatch = dispatch();
  const loading = state.applicationInstances.loading;
  const applicationInstances = _.filter(state.applicationInstances.applicationInstances,
    { application_id: parseInt(params.applicationId, 10) });
  const applications = state.applications;
  const sites = state.sites;

  useEffect(() => {
    dispatch(
      getApplicationInstance(params.applicationId, params.applicationInstanceId)
    )
  },
  []);

  const application = applications[params.applicationId];
  const applicationInstance = _.filter(applicationInstances, (app) => (
    app.id === _.parseInt(params.applicationInstanceId)
  ))[0];
  let backPath = '';
  if (!loading) {
    backPath = `/applications/${application.id}/application_instances`;

  }

  const renderLoading = () => (
    <div className="aj-loading-space-top">
      <Loader />
    </div>
  );

  return (
    <div>
      <Heading
        backTo="/applications"
        application={application}
      />
      {loading ? renderLoading() : (
        <div className="aj-admin-container">
          <Header
            goBack={() => router.push(backPath)}
            applicationInstance={applicationInstance}
            application={application}
            deleteInstance={deleteApplicationInstance}
            disableInstance={disableApplicationInstance}
          />
          <ApplicationInstanceSettings
            application={application}
            applicationInstance={applicationInstance}
            sites={sites}
            tabComponent={children}
            location={location}
          />
        </div>
      )}
    </div>
  );
}

Index.propTypes = {
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
  getApplicationInstance: PropTypes.func,
  router: PropTypes.shape({
    push: PropTypes.func,
  }),
  deleteApplicationInstance: PropTypes.func,
  disableApplicationInstance: PropTypes.func,
  children: PropTypes.element,
  location: PropTypes.shape({}),
};
