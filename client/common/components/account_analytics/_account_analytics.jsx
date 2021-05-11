import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import AccountReport from './account_report';
import Graph from './account_graphs';
import { getApplicationInstance } from '../../../apps/admin/actions/application_instances';

import Loader from '../common/atomicjolt_loader';

function select(state, props) {
  const { accountAnalytics } = state;
  const { params } = props;
  return {
    loaded: accountAnalytics.userSearchesLoaded,
    loading: accountAnalytics.userSearchesLoading,
    applicationInstances: params ? _.filter(state.applicationInstances.applicationInstances,
      { application_id: parseInt(params.applicationId, 10) }) : [],
    applications: state.applications,
  };
}

export function AccountAnalytics(props) {
  const { loading, loaded, params, applicationInstances } = props;

  const onAdminPanel = params.applicationId && params.applicationInstanceId;

  useEffect(() => {
    if (!loading && !loaded) {
      if (onAdminPanel) {
        props.getApplicationInstance(params.applicationId, params.applicationInstanceId);
      }
    }
  }
  , []);

  let tenant = null;

  if(onAdminPanel) {
    const applicationInstance = _.filter(applicationInstances, (app) => (
      app.id === _.parseInt(params.applicationInstanceId)
    ))[0];
    tenant = applicationInstance.lti_key;
  }

  return (
    <>
      {loading || !loaded ?
        <Loader /> :
        <div>
          <Graph tenant={tenant} />
          <AccountReport tenant={tenant} />
        </div>
      }
    </>
  );
}

AccountAnalytics.propTypes = {
  getApplicationInstance: PropTypes.func,
  applicationInstances: PropTypes.array,
  loading: PropTypes.bool,
  loaded: PropTypes.bool,
  router: PropTypes.shape({
    goBack: PropTypes.func,
  }),
  params: PropTypes.shape({
    applicationId: PropTypes.string,
    applicationInstanceId: PropTypes.string,

  }),
};

export default connect(
  select,
  { getApplicationInstance }
)(AccountAnalytics);
