import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';
import Heading from '../common/heading';
import Header from './header';
import ApplicationInstanceSettings from './application_instance_settings';
import Loader from '../../../../common/components/common/atomicjolt_loader';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import { useDispatch, useSelector } from 'react-redux';

export default function Index(props) {

  const {
    router,
    params,
    deleteApplicationInstance,
    disableApplicationInstance,
    children,
  } = props;

  const dispatch = useDispatch();
  const loading = useSelector((state) => state.applicationInstances.loading);
  const applicationInstances = useSelector((state) => state.applicationInstances);
  const applications = useSelector((state) => state.applications);

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
