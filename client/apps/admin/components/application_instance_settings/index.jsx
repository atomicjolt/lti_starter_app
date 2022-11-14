import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Heading from '../common/heading';
import Header from './header';
import ApplicationInstanceSettings from './application_instance_settings';
import Loader from '../../../../common/components/common/atomicjolt_loader';
import * as ApplicationInstanceActions from '../../actions/application_instances';

const select = (state, props) => ({
  loading: state.applicationInstances.loading,
  applicationInstances: _.filter(state.applicationInstances.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  applications: state.applications,
  sites: state.sites,
});

export function Index(props) {

  const {
    router,
    applicationInstances,
    loading,
    params,
    applications,
    deleteApplicationInstance,
    disableApplicationInstance,
    sites,
    children,
    location,
  } = props;

  useEffect(() => {
    props.getApplicationInstance(params.applicationId, params.applicationInstanceId);
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

export default connect(select, ApplicationInstanceActions)(Index);

Index.propTypes = {
  params: PropTypes.shape({
    applicationId: PropTypes.string.isRequired,
    applicationInstanceId: PropTypes.string.isRequired,
  }).isRequired,
  applications: PropTypes.shape({
    id: PropTypes.string.isRequired,
  }).isRequired,
  getApplicationInstance: PropTypes.func,
  applicationInstances: PropTypes.array,
  router: PropTypes.shape({
    push: PropTypes.func,
  }),
  loading: PropTypes.bool,
  sites: PropTypes.shape({}).isRequired,
  deleteApplicationInstance: PropTypes.func,
  disableApplicationInstance: PropTypes.func,
  children: PropTypes.element,
  location: PropTypes.shape({}),
};
